QUERIES = {
    'q1': {
        'title': 'All Customers',
        'subtitle': 'Q1 — Sorted by customer name',
        'sql': """SELECT customer_id, customer_name, customer_type,
       customer_email, customer_phone, country
FROM customers
ORDER BY customer_name ASC""",
        'headers': ['ID', 'Name', 'Type', 'Email', 'Phone', 'Country'],
    },
    'q2': {
        'title': 'Booking Schedule',
        'subtitle': 'Q2 — Shipment and flight details',
        'sql': """SELECT s.awb_number, s.origin_airport, s.destination_airport,
       f.flight_no, f.airline, f.dep_time, f.arr_time,
       f.aircraft_type, s.weight_kg, s.service_type, s.status
FROM shipments s
JOIN flight_shipment fs ON s.shipment_id = fs.shipment_id
JOIN flights f ON fs.flight_id = f.flight_id
WHERE YEAR(f.dep_time) = {year}
ORDER BY s.origin_airport, f.flight_no, f.dep_time""",
        'headers': ['AWB', 'Origin', 'Destination', 'Flight', 'Airline', 'Departure', 'Arrival', 'Aircraft', 'Weight (kg)', 'Service', 'Status'],
        'params': ['year'],
    },
    'q3': {
        'title': 'Aged Bookings',
        'subtitle': 'Q3 — Booked but not departed 30+ days',
        'sql': """SELECT s.awb_number, s.origin_airport, s.destination_airport,
       s.booking_date, s.status, s.weight_kg, s.service_type,
       DATEDIFF(CURDATE(), s.booking_date) AS days_on_hold
FROM shipments s
WHERE s.status = 'Booked'
AND YEAR(s.booking_date) = {year}
AND DATEDIFF(CURDATE(), s.booking_date) > 30
ORDER BY days_on_hold DESC""",
        'headers': ['AWB', 'Origin', 'Destination', 'Booking Date', 'Status', 'Weight (kg)', 'Service', 'Days on Hold'],
        'params': ['year'],
    },
    'q4': {
        'title': 'Business Value by Shipper',
        'subtitle': 'Q4 — Revenue per shipper',
        'sql': """SELECT c.customer_name, c.customer_type,
       COUNT(s.shipment_id) AS total_shipments,
       SUM(s.weight_kg) AS total_weight_kg,
       SUM(GREATEST(s.weight_kg * sr.rate_per_kg, sr.min_charge)) AS total_value
FROM shipments s
JOIN customers c ON s.shipper_id = c.customer_id
JOIN service_rates sr ON s.origin_airport = sr.origin_airport
    AND s.destination_airport = sr.destination_airport
    AND s.service_type = sr.service_type
WHERE YEAR(s.booking_date) = {year}
GROUP BY c.customer_id, c.customer_name, c.customer_type
ORDER BY total_value DESC""",
        'headers': ['Shipper', 'Type', 'Shipments', 'Total Weight (kg)', 'Total Value (£)'],
        'params': ['year'],
    },
    'q6': {
        'title': 'Cancelled Shipments Value',
        'subtitle': 'Q6 — Revenue lost to cancellations',
        'sql': """SELECT COUNT(s.shipment_id) AS total_cancelled,
       SUM(s.weight_kg) AS total_weight_kg,
       SUM(GREATEST(s.weight_kg * sr.rate_per_kg, sr.min_charge)) AS total_lost_value
FROM shipments s
JOIN service_rates sr ON s.origin_airport = sr.origin_airport
    AND s.destination_airport = sr.destination_airport
    AND s.service_type = sr.service_type
WHERE s.status = 'Cancelled'
AND YEAR(s.booking_date) = {year}""",
        'headers': ['Total Cancelled', 'Total Weight (kg)', 'Total Lost Value (£)'],
        'params': ['year'],
    },
    'q7': {
        'title': 'ULD Usage Count',
        'subtitle': 'Q7 — Usage per ULD including unused',
        'sql': """SELECT u.uld_id, u.uld_code, u.type_code, u.owner_code, u.uld_condition,
       COUNT(DISTINCT fs.shipment_id) AS times_used
FROM ulds u
LEFT JOIN shipment_uld su ON u.uld_id = su.uld_id
LEFT JOIN flight_uld fu ON u.uld_id = fu.uld_id
LEFT JOIN flights f ON fu.flight_id = f.flight_id
    AND YEAR(f.dep_time) = {year}
LEFT JOIN flight_shipment fs ON f.flight_id = fs.flight_id
GROUP BY u.uld_id, u.uld_code, u.type_code, u.owner_code, u.uld_condition
ORDER BY u.uld_id""",
        'headers': ['ULD ID', 'ULD Code', 'Type', 'Owner', 'Condition', 'Times Used'],
        'params': ['year'],
    },
    'q8': {
        'title': 'Inactive Customers',
        'subtitle': 'Q8 — Customers with no bookings',
        'sql': """SELECT c.customer_id, c.customer_name, c.customer_type,
       c.customer_email, c.country
FROM customers c
WHERE c.customer_id NOT IN (
    SELECT DISTINCT s.shipper_id
    FROM shipments s
    WHERE YEAR(s.booking_date) = {year}
    AND s.shipper_id IS NOT NULL
)
ORDER BY c.customer_name ASC""",
        'headers': ['ID', 'Name', 'Type', 'Email', 'Country'],
        'params': ['year'],
    },
}
