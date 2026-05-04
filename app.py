from flask import Flask, render_template, request
from markupsafe import Markup
from db import get_db
from utils import highlight_sql, render_table, year_select, query_page
from queries import QUERIES

app = Flask(__name__)

# ── Generic query handler ─────────────────────────────────
def run_query(key):
    q = QUERIES[key]
    year = request.args.get('year', '2025')
    sql = q['sql'].format(year=year) if 'params' in q else q['sql']

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(sql)
    rows = cursor.fetchall()
    cursor.close()
    conn.close()

    controls = ''
    if 'params' in q and 'year' in q['params']:
        controls = f'<label style="font-size:13px;color:var(--text-muted)">Year</label>{year_select(year)}'

    return query_page(
        title=q['title'],
        subtitle=f"{q['subtitle']} — {year}" if 'params' in q else q['subtitle'],
        sql=sql,
        headers=q['headers'],
        rows=rows,
        controls=controls,
        active=key
    )

# ── Home ──────────────────────────────────────────────────
@app.route('/')
def index():
    cards = [
        ('q1', 'Q1', 'All Customers', 'Display all customers sorted by name.', 'ORDER BY'),
        ('q2', 'Q2', 'Booking Schedule', 'Flight and routing details for a selected year.', 'JOIN'),
        ('q3', 'Q3', 'Aged Bookings', 'Shipments booked but not departed for 30+ days.', 'DATEDIFF'),
        ('q4', 'Q4', 'Business Value', 'Total revenue per shipper for a selected year.', 'SUM / GROUP BY'),
        ('q5', 'Q5', 'Tracking Events', 'Shipment timeline for a selected shipper and year.', 'JOIN'),
        ('q6', 'Q6', 'Cancellations', 'Total value of cancelled shipments for a year.', 'SUM / WHERE'),
        ('q7', 'Q7', 'ULD Usage', 'Usage count per ULD including unused containers.', 'LEFT JOIN'),
        ('q8', 'Q8', 'Inactive Customers', 'Customers with no bookings in a selected year.', 'SUBQUERY'),
        ('q9', 'Q9', 'Status Trigger', 'Auto-update shipment status from tracking events.', 'TRIGGER'),
    ]

    grid = ''
    for route, num, title, desc, tag in cards:
        grid += f'''
        <a href="/{route}" class="query-card">
          <div class="card-header">
            <span class="card-number">{num}</span>
            <span class="card-tag">{tag}</span>
          </div>
          <div class="card-title">{title}</div>
          <div class="card-desc">{desc}</div>
        </a>'''

    content = Markup(f'''
    <div class="home-header">
      <div class="home-title">Query Dashboard</div>
      <div class="home-desc">Select a query below to run it against the AirCargo RealTime database. Each query demonstrates a different SQL concept.</div>
    </div>
    <div class="query-grid">{grid}</div>
    ''')

    return render_template('base.html',
        active='home',
        page_title='AirCargo RealTime',
        page_subtitle='Database Query System',
        content=content)

# ── Generic routes ────────────────────────────────────────
@app.route('/q1')
def q1(): return run_query('q1')

@app.route('/q2')
def q2(): return run_query('q2')

@app.route('/q3')
def q3(): return run_query('q3')

@app.route('/q4')
def q4(): return run_query('q4')

@app.route('/q6')
def q6(): return run_query('q6')

@app.route('/q7')
def q7(): return run_query('q7')

@app.route('/q8')
def q8(): return run_query('q8')

# ── Q5 — Tracking Events (special: shipper dropdown) ──────
@app.route('/q5')
def q5():
    year = request.args.get('year', '2025')
    shipper_id = request.args.get('shipper_id', '')

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute("SELECT customer_id, customer_name FROM customers WHERE customer_type = 'shipper' ORDER BY customer_name")
    shippers = cursor.fetchall()

    sql = f"""SELECT s.awb_number, s.origin_airport, s.destination_airport,
       s.booking_date, s.status, te.event_type,
       te.location, te.timestamp, te.notes
FROM shipments s
JOIN tracking_events te ON s.shipment_id = te.shipment_id
JOIN customers c ON s.shipper_id = c.customer_id
WHERE c.customer_id = {shipper_id if shipper_id else 'NULL'}
AND YEAR(s.booking_date) = {year}
ORDER BY s.booking_date, te.timestamp"""

    rows = []
    if shipper_id:
        cursor.execute(f"""SELECT s.awb_number, s.origin_airport, s.destination_airport,
               s.booking_date, s.status, te.event_type, te.location, te.timestamp, te.notes
            FROM shipments s
            JOIN tracking_events te ON s.shipment_id = te.shipment_id
            JOIN customers c ON s.shipper_id = c.customer_id
            WHERE c.customer_id = %s AND YEAR(s.booking_date) = %s
            ORDER BY s.booking_date, te.timestamp""", (shipper_id, year))
        rows = cursor.fetchall()

    cursor.close()
    conn.close()

    shipper_opts = ''.join(
        f'<option value="{s[0]}" {"selected" if str(s[0]) == shipper_id else ""}>{s[1]}</option>'
        for s in shippers
    )

    controls = f'''
        <label style="font-size:13px;color:var(--text-muted)">Year</label>
        {year_select(year)}
        <label style="font-size:13px;color:var(--text-muted)">Shipper</label>
        <div class="select-wrap">
          <select name="shipper_id" onchange="this.form.submit()">
            <option value="">— Select —</option>
            {shipper_opts}
          </select>
        </div>'''

    headers = ['AWB', 'Origin', 'Dest', 'Booking Date', 'Status', 'Event', 'Location', 'Timestamp', 'Notes']
    return query_page(
        title='Tracking Events by Shipper',
        subtitle=f'Q5 — Shipment timeline for {year}',
        sql=sql,
        headers=headers,
        rows=rows,
        controls=controls,
        active='q5'
    )

# ── Q9 — Trigger ──────────────────────────────────────────
@app.route('/q9')
def q9():
    sql = """DROP TRIGGER IF EXISTS update_shipment_status;

CREATE TRIGGER update_shipment_status
AFTER INSERT ON tracking_events
FOR EACH ROW
BEGIN
    IF NEW.event_type = 'FlightDeparted' THEN
        UPDATE shipments SET status = 'In Transit'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    ELSEIF NEW.event_type = 'ProofOfDelivery' THEN
        UPDATE shipments SET status = 'Delivered'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    ELSEIF NEW.event_type = 'FlightArrived' THEN
        UPDATE shipments SET status = 'Arrived'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    ELSEIF NEW.event_type = 'CustomsCleared' THEN
        UPDATE shipments SET status = 'Customs Cleared'
        WHERE shipment_id = NEW.shipment_id
        AND status != 'Cancelled';
    END IF;
END"""

    sql_highlighted = highlight_sql(sql)

    trigger_table = '''
    <table class="trigger-table">
      <thead><tr><th>Event Type</th><th>New Shipment Status</th><th>Protected?</th></tr></thead>
      <tbody>
        <tr><td>FlightDeparted</td><td><span class="status-badge badge-blue">In Transit</span></td><td>Cancelled shipments excluded</td></tr>
        <tr><td>FlightArrived</td><td><span class="status-badge badge-orange">Arrived</span></td><td>Cancelled shipments excluded</td></tr>
        <tr><td>CustomsCleared</td><td><span class="status-badge badge-orange">Customs Cleared</span></td><td>Cancelled shipments excluded</td></tr>
        <tr><td>ProofOfDelivery</td><td><span class="status-badge badge-green">Delivered</span></td><td>Cancelled shipments excluded</td></tr>
      </tbody>
    </table>'''

    content = Markup(f'''
    <a href="/" class="back-link">← Back to queries</a>
    <div class="success-banner">
      ✓ Trigger <strong>update_shipment_status</strong> is active on the tracking_events table
    </div>
    <div class="query-layout">
      <div class="results-panel">
        <div class="panel-header">
          <span class="panel-title">Trigger Behaviour</span>
        </div>
        <div class="trigger-card" style="border:none;border-radius:0;box-shadow:none;margin:0">
          <div class="trigger-desc">
            This trigger fires automatically after every INSERT on the <strong>tracking_events</strong> table.
            It evaluates the event type and updates the corresponding shipment status without any manual intervention.
            Cancelled shipments are protected and will never be overwritten.
          </div>
          {trigger_table}
        </div>
      </div>
      <div class="sql-panel">
        <div class="sql-card">
          <div class="sql-header">
            <span class="sql-title">Trigger Definition</span>
            <div class="sql-dots">
              <div class="sql-dot" style="background:#f38ba8"></div>
              <div class="sql-dot" style="background:#fab387"></div>
              <div class="sql-dot" style="background:#a6e3a1"></div>
            </div>
          </div>
          <div class="sql-body">{sql_highlighted}</div>
        </div>
      </div>
    </div>''')

    return render_template('base.html',
        active='q9',
        page_title='Status Trigger',
        page_subtitle='Q9 — Auto-update shipment status from tracking events',
        content=content)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
