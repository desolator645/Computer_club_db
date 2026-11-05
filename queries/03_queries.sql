-- 1. Все клиенты
SELECT * FROM clients ORDER BY client_id;

-- 2. Компьютеры и статусы
SELECT computer_id, place_number, specifications, status
FROM computers ORDER BY place_number;

-- 3. Тарифы
SELECT * FROM tariffs ORDER BY price_per_hour;

-- 4. Активные сеансы
SELECT s.session_id, c.display_name AS client, pc.place_number,
       t.tariff_name, s.started_at
FROM sessions s
JOIN clients c ON c.client_id = s.client_id
JOIN computers pc ON pc.computer_id = s.computer_id
JOIN tariffs t ON t.tariff_id = s.tariff_id
WHERE s.ended_at IS NULL
ORDER BY s.started_at;

-- 5. История сеансов клиента № 1
SELECT s.session_id, c.display_name, pc.place_number, t.tariff_name,
       s.started_at, s.ended_at, s.total_cost
FROM sessions s
JOIN clients c ON c.client_id = s.client_id
JOIN computers pc ON pc.computer_id = s.computer_id
JOIN tariffs t ON t.tariff_id = s.tariff_id
WHERE c.client_id = 1
ORDER BY s.started_at DESC;

-- 6. Выручка по дням
SELECT paid_at::date AS payment_date, SUM(amount) AS daily_revenue
FROM payments
GROUP BY paid_at::date
ORDER BY payment_date;

-- 7. Сумма платежей по тарифам
SELECT t.tariff_name, COALESCE(SUM(p.amount), 0) AS revenue
FROM tariffs t
LEFT JOIN sessions s ON s.tariff_id = t.tariff_id
LEFT JOIN payments p ON p.session_id = s.session_id
GROUP BY t.tariff_id, t.tariff_name
ORDER BY revenue DESC;

-- 8. Стоимость сеанса и сумма оплат
SELECT s.session_id, c.display_name, s.total_cost,
       COALESCE(SUM(p.amount), 0) AS paid_amount,
       COALESCE(SUM(p.amount), 0) - COALESCE(s.total_cost, 0) AS balance
FROM sessions s
JOIN clients c ON c.client_id = s.client_id
LEFT JOIN payments p ON p.session_id = s.session_id
GROUP BY s.session_id, c.display_name, s.total_cost
ORDER BY s.session_id;
