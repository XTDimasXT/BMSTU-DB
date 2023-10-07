copy lab.Users(book_id, bet_id, transaction_id, ticket_id, last_name, first_name, passport_series, passport_number, ban_status) FROM 'data/users.csv' DELIMITER ',' CSV HEADER;
copy lab.Bookmakers(bookmaker_name, profit, marketing_spent, users, active_users) FROM 'data/bookmakers.csv' DELIMITER ',' CSV HEADER;
copy lab.Bets(kind_of_sport, summ, coefficient, bet_status, bet_type) FROM 'data/bets.csv' DELIMITER ',' CSV HEADER;
copy lab.Transactions(transaction_type, bank, summ, transaction_status, transaction_date) FROM 'data/transactions.csv' DELIMITER ',' CSV HEADER;
copy lab.Tickets(worker_last_name, worker_first_name, theme, ticket_status, ticket_date) FROM 'data/tickets.csv' DELIMITER ',' CSV HEADER;