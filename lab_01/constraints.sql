ALTER TABLE lab.Bookmakers
    ADD CONSTRAINT check_profit_positive CHECK (profit >= 0);
ALTER TABLE lab.Bookmakers
    ADD CONSTRAINT check_users_positive CHECK (users >= 0);
ALTER TABLE lab.Bookmakers
    ADD CONSTRAINT check_active_users_positive CHECK (active_users >= 0);
ALTER TABLE lab.Bookmakers
    ADD CONSTRAINT check_active_users_less_equal_users CHECK (active_users <= users);

ALTER TABLE lab.Bets
    ADD CONSTRAINT check_summ_bet CHECK (summ > 0);
ALTER TABLE lab.Bets
    ADD CONSTRAINT check_coefficient CHECK (coefficient >= 1.0);

ALTER TABLE lab.Transactions
    ADD CONSTRAINT check_sum_transaction CHECK (summ > 0);
ALTER TABLE lab.Transactions
    ADD CONSTRAINT check_date_transaction CHECK (transaction_date <= current_date);

ALTER TABLE lab.Tickets
    ADD CONSTRAINT check_date_ticket CHECK (ticket_date <= current_date);

ALTER TABLE lab.Users
    ADD CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES lab.Bookmakers(id);
ALTER TABLE lab.Users
    ADD CONSTRAINT fk_bet FOREIGN KEY (bet_id) REFERENCES lab.Bets(id);
ALTER TABLE lab.Users
    ADD CONSTRAINT fk_transaction FOREIGN KEY (transaction_id) REFERENCES lab.Transactions(id);
ALTER TABLE lab.Users
    ADD CONSTRAINT fk_ticket FOREIGN KEY (ticket_id) REFERENCES lab.Tickets(id);