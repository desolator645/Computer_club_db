INSERT INTO clients (display_name, phone) VALUES
('Александр Иванов', '+79000000001'),
('Дмитрий Смирнов', '+79000000002'),
('Максим Петров', '+79000000003'),
('Артём Соколов', '+79000000004'),
('Илья Козлов', '+79000000005');

INSERT INTO computers (place_number, specifications, status) VALUES
(1, 'Ryzen 5, 16 GB RAM, RTX 3060', 'available'),
(2, 'Ryzen 5, 16 GB RAM, RTX 4060', 'available'),
(3, 'Core i5, 16 GB RAM, RTX 3060', 'maintenance'),
(4, 'Ryzen 7, 32 GB RAM, RTX 4070', 'available'),
(5, 'Core i5, 16 GB RAM, RTX 4060', 'disabled');

INSERT INTO tariffs (tariff_name, price_per_hour) VALUES
('Стандарт', 100.00),
('Комфорт', 150.00),
('VIP', 250.00);

INSERT INTO sessions (client_id, computer_id, tariff_id, started_at, ended_at, total_cost) VALUES
(1, 1, 1, CURRENT_TIMESTAMP - INTERVAL '3 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour', 200.00),
(2, 2, 2, CURRENT_TIMESTAMP - INTERVAL '2 hours', CURRENT_TIMESTAMP - INTERVAL '1 hour', 150.00),
(3, 4, 3, CURRENT_TIMESTAMP - INTERVAL '1 hour', NULL, NULL),
(4, 1, 1, CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '4 hours', 200.00);

INSERT INTO payments (session_id, amount, payment_method) VALUES
(1, 200.00, 'card'),
(2, 150.00, 'cash'),
(4, 200.00, 'card');
