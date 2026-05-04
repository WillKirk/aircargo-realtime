import re
from markupsafe import Markup
from flask import render_template

def highlight_sql(sql):
    keywords = ['SELECT', 'FROM', 'WHERE', 'JOIN', 'LEFT', 'INNER', 'ON', 'AND', 'OR',
                'ORDER', 'BY', 'GROUP', 'HAVING', 'AS', 'DISTINCT', 'NOT', 'IN',
                'IS', 'NULL', 'ASC', 'DESC', 'YEAR', 'COUNT', 'SUM', 'MAX', 'MIN',
                'AVG', 'GREATEST', 'DATEDIFF', 'CURDATE', 'CREATE', 'TRIGGER',
                'AFTER', 'INSERT', 'FOR', 'EACH', 'ROW', 'BEGIN', 'END', 'IF',
                'THEN', 'ELSEIF', 'UPDATE', 'SET', 'DROP', 'IF EXISTS', 'INTO',
                'VALUES', 'DELIMITER']
    result = sql.strip()
    result = result.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')
    for kw in sorted(keywords, key=len, reverse=True):
        result = re.sub(rf'\b{kw}\b', f'<span class="kw">{kw}</span>', result, flags=re.IGNORECASE)
    result = re.sub(r"'([^']*)'", r'<span class="str">\'\1\'</span>', result)
    result = re.sub(r'\b(\d+\.?\d*)\b', r'<span class="num">\1</span>', result)
    result = re.sub(r'--.*$', r'<span class="cm">\g<0></span>', result, flags=re.MULTILINE)
    return result

def render_table(headers, rows):
    if not rows:
        return '<div class="empty-state">No results found for the selected filters.</div>'
    ths = ''.join(f'<th>{h}</th>' for h in headers)
    trs = ''
    for row in rows:
        tds = ''.join(f'<td>{c if c is not None else ""}</td>' for c in row)
        trs += f'<tr>{tds}</tr>'
    return f'<div class="table-wrap"><table><thead><tr>{ths}</tr></thead><tbody>{trs}</tbody></table></div>'

def year_select(year, name='year'):
    opts = ''
    for y in ['2024', '2025', '2026']:
        sel = 'selected' if year == y else ''
        opts += f'<option value="{y}" {sel}>{y}</option>'
    return f'<div class="select-wrap"><select name="{name}" onchange="this.form.submit()">{opts}</select></div>'

def query_page(title, subtitle, sql, headers, rows, controls='', active='', extra=''):
    count = f'{len(rows)} row{"s" if len(rows) != 1 else ""}' if rows else '0 rows'
    table_html = render_table(headers, rows)
    sql_highlighted = highlight_sql(sql)

    content = Markup(f'''
    <a href="/" class="back-link">← Back to queries</a>
    {f'<form method="get"><div class="controls">{controls}</div></form>' if controls else ''}
    <div class="query-layout">
      <div class="results-panel">
        <div class="panel-header">
          <span class="panel-title">Results</span>
          <span class="result-count">{count}</span>
        </div>
        {extra}
        {table_html}
      </div>
      <div class="sql-panel">
        <div class="sql-card">
          <div class="sql-header">
            <span class="sql-title">SQL Query</span>
            <div class="sql-dots">
              <div class="sql-dot" style="background:#f38ba8"></div>
              <div class="sql-dot" style="background:#fab387"></div>
              <div class="sql-dot" style="background:#a6e3a1"></div>
            </div>
          </div>
          <div class="sql-body">{sql_highlighted}</div>
        </div>
      </div>
    </div>
    ''')

    return render_template('base.html',
        active=active,
        page_title=title,
        page_subtitle=subtitle,
        content=content)
