CREATE TABLE exchange_rates (
    date DATE NOT NULL,
    sell_currency TEXT NOT NULL,
    buy_currency TEXT NOT NULL,
    rate DECIMAL NOT NULL,

    PRIMARY KEY (date, sell_currency, buy_currency)
);

CREATE TABLE transactions (
    id UUID PRIMARY KEY,
    booked_time TIMESTAMP WITH TIME ZONE NOT NULL,
    client_name TEXT NOT NULL,
    revenue DECIMAL NOT NULL,
    currency TEXT NOT NULL
);

CREATE TABLE line_items (
    id UUID PRIMARY KEY,
    transaction_id UUID NOT NULL,
    details JSONB
);
