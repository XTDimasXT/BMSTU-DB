import random
import os

from config import fake, cur_dir, BOOKMAKERS, BANKS, SPORTS, STATUS_ACCOUNT, STATUS_BETS, STATUS_TICKETS, STATUS_TRANSACTIONS, TYPES_BETS, TYPES_TRANSACTIONS, THEMES_TICKETS, COUNT


def generate_user():
    last_name = fake.last_name()
    first_name = fake.first_name()
    passport_series = str(random.randint(1000, 9999))
    passport_number = str(random.randint(100000, 999999))
    ban_status = random.choice(STATUS_ACCOUNT)

    data = [last_name, first_name, passport_series, passport_number, ban_status]
    res = ",". join(data)

    return res


def generate_users():
    file_name = cur_dir + "/users.csv"
    file = open(file_name, "w")

    header = "last_name,first_name,passport_series,passport_number,ban_status"
    file.write(header)
    file.write('\n')

    for _ in range(COUNT):
        file.write(generate_user())
        file.write('\n')


def generate_bookmaker():
    bookmaker_name = random.choice(BOOKMAKERS)
    profit = str(random.randint(10_000_000, 100_000_000))
    marketing_spent = str(random.randint(1_000_000, 10_000_000))
    users = str(random.randint(10_000, 100_000))
    active_users = str(random.randint(10_000, int(users)))

    data = [bookmaker_name, profit, marketing_spent, users, active_users]
    res = ",". join(data)

    return res


def generate_bookmakers():
    file_name = cur_dir + "/bookmakers.csv"
    file = open(file_name, "w")

    header = "bookmaker_name,profit,marketing_spent,users,active_users"
    file.write(header)
    file.write('\n')

    for _ in range(COUNT):
        file.write(generate_bookmaker())
        file.write('\n')


def generate_bet():
    kind_of_sport = random.choice(SPORTS)
    summ = str(random.randint(100, 100_000))
    coefficient = str(round(random.uniform(1.0, 25.0), 2))
    bet_status = str(random.choice(STATUS_BETS))
    bet_type = random.choice(TYPES_BETS)

    data = [kind_of_sport, summ, coefficient, bet_status, bet_type]
    res = ",". join(data)

    return res


def generate_bets():
    file_name = cur_dir + "/bets.csv"
    file = open(file_name, "w")

    header = "kind_of_sport, summ, coefficient, bet_status, bet_type"
    file.write(header)
    file.write('\n')

    for _ in range(COUNT):
        file.write(generate_bet())
        file.write('\n')


def generate_transaction():
    transaction_type = random.choice(TYPES_TRANSACTIONS)
    bank = random.choice(BANKS)
    summ = str(random.randint(1_000, 60_000))
    transaction_status = random.choice(STATUS_TRANSACTIONS)
    transaction_date = fake.date()

    data = [transaction_type, bank, summ, transaction_status, transaction_date]
    res = ",". join(data)

    return res


def generate_transactions():
    file_name = cur_dir + "/transactions.csv"
    file = open(file_name, "w")

    header = "transaction_type, bank, summ, transaction_status, transaction_date"
    file.write(header)
    file.write('\n')

    for _ in range(COUNT):
        file.write(generate_transaction())
        file.write('\n')


def generate_ticket():
    worker_last_name = fake.last_name()
    worker_first_name = fake.first_name()
    theme = random.choice(THEMES_TICKETS)
    ticket_status = random.choice(STATUS_TICKETS)
    ticket_date = fake.date()

    data = [worker_last_name, worker_first_name, theme, ticket_status, ticket_date]
    res = ",". join(data)

    return res


def generate_tickets():
    file_name = cur_dir + "/tickets.csv"
    file = open(file_name, "w")

    header = "worker_last_name, worker_first_name, theme, ticket_status, ticket_date"
    file.write(header)
    file.write('\n')

    for _ in range(COUNT):
        file.write(generate_ticket())
        file.write('\n')


def main():
    generate_users()
    generate_bookmakers()
    generate_bets()
    generate_transactions()
    generate_tickets()


if __name__ == "__main__":
    main()