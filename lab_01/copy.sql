copy lab.Users(last_name, first_name, passport_series, passport_number, ban_status) FROM 'csv/users.csv' DELIMITER ',' csv HEADER;
copy lab.Bookmakers(bookmaker_name, profit, marketing_spent, users, active_users) FROM 'csv/bookmakers.csv' DELIMITER ',' csv HEADER;
copy lab.Bets(kind_of_sport, summ, coefficient, bet_status, bet_type) FROM 'csv/bets.csv' DELIMITER ',' csv HEADER;
copy lab.Transactions(transaction_type, bank, summ, transaction_status, transaction_date) FROM 'csv/transactions.csv' DELIMITER ',' csv HEADER;
copy lab.Tickets(worker_last_name, worket_first_name, theme, ticket_status, ticket_date) FROM 'csv/tickets.csv' DELIMITER ',' csv HEADER;