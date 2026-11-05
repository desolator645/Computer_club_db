CREATE TABLE clients (
    client_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    display_name VARCHAR(120) NOT NULL,
    phone VARCHAR(30),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE computers (
    computer_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    place_number INTEGER NOT NULL UNIQUE CHECK (place_number > 0),
    specifications TEXT,
    status VARCHAR(20) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available', 'maintenance', 'disabled'))
);

CREATE TABLE tariffs (
    tariff_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tariff_name VARCHAR(80) NOT NULL UNIQUE,
    price_per_hour NUMERIC(10,2) NOT NULL CHECK (price_per_hour >= 0)
);

CREATE TABLE sessions (
    session_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id BIGINT NOT NULL REFERENCES clients(client_id),
    computer_id BIGINT NOT NULL REFERENCES computers(computer_id),
    tariff_id BIGINT NOT NULL REFERENCES tariffs(tariff_id),
    started_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP,
    total_cost NUMERIC(10,2) CHECK (total_cost >= 0),
    CHECK (ended_at IS NULL OR ended_at >= started_at)
);

CREATE TABLE payments (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id BIGINT NOT NULL REFERENCES sessions(session_id),
    paid_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    amount NUMERIC(10,2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(30) NOT NULL
);

CREATE INDEX idx_sessions_client_id ON sessions(client_id);
CREATE INDEX idx_sessions_computer_id ON sessions(computer_id);
CREATE INDEX idx_sessions_tariff_id ON sessions(tariff_id);
CREATE INDEX idx_payments_session_id ON payments(session_id);
