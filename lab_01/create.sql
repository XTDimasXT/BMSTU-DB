CREATE SCHEMA IF NOT EXISTS lab;

CREATE TABLE IF NOT EXISTS lab.Users(
    id SERIAL PRIMARY KEY,
    book_id INT,
    bet_id INT,
    transaction_id INT,
    ticket_id INT,
    last_name TEXT NOT NULL,
    first_name TEXT NOT NULL,
    passport_series INT NOT NULL,
    passport_number INT NOT NULL,
    ban_status TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS lab.Bookmakers(
    id SERIAL PRIMARY KEY,
    bookmaker_name TEXT NOT NULL,
    profit INT NOT NULL,
    marketing_spent INT NOT NULL,
    users INT NOT NULL,
    active_users INT NOT NULL
);

CREATE TABLE IF NOT EXISTS lab.Bets(
    id SERIAL PRIMARY KEY,
    kind_of_sport TEXT NOT NULL,
    summ INT NOT NULL,
    coefficient DECIMAL(5, 2),
    bet_status TEXT NOT NULL,
    bet_type TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS lab.Transactions(
    id SERIAL PRIMARY KEY,
    transaction_type TEXT NOT NULL,
    bank TEXT NOT NULL,
    summ INT NOT NULL,
    transaction_status TEXT NOT NULL,
    transaction_date DATE
);

CREATE TABLE IF NOT EXISTS lab.Tickets(
    id SERIAL PRIMARY KEY,
    worker_last_name TEXT NOT NULL,
    worket_first_name TEXT NOT NULL,
    theme TEXT NOT NULL,
    ticket_status TEXT NOT NULL,
    ticket_date DATE
);