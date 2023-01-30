create or replace dummy_db.public.cards (
        user integer,
        card_index integer,
        card_brand text,
        card_type text,
        card_number text,
        expires text,
        cvv integer,
        has_chip boolean,
        card_issued integer,
        credit_limit text,
        acct_open_date text,
        year_pin_last_changed integer,
        card_on_dark_web boolean
    );
alter table dummy_db.public.cards
add primary key (user, card_number);
create stage card_temp file_format = (type = csv);
put 'file:///opt/airflow/dags/data/cards.csv' @card_temp auto_compress = true;
copy into dummy_db.public.cards
from @card_temp file_format = (type = csv) on_error = 'skip_file';
create or replace dummy_db.public.transactions (
        user integer,
        card integer,
        year integer,
        month integer,
        day integer,
        time time,
        amount text,
        use_chip text,
        card_number text,
        merchant_city text,
        merchant_state text,
        zip integer,
        mcc integer,
        errors text,
        is_fraud boolean
    );
alter table dummy_db.public.transactions
add primary key (
        user,
        card,
        year,
        month,
        day,
        time,
        amount
    );
create stage transaction_temp file_format = (type = csv);
put 'file:///opt/airflow/dags/data/transactions.csv' @transaction_temp auto_compress = true;
copy into dummy_db.public.transactions
from @transaction_temp file_format = (type = csv) on_error = 'skip_file';
create or replace dummy_db.public.users(
        user integer,
        person text,
        current_age integer,
        retirement_age integer,
        birth_year integer,
        birth_month integer,
        gender text,
        address text,
        apartment integer,
        city text,
        state text,
        zip integer,
        latitude numeric,
        longitude numeric,
        zip_income_per_capita numeric,
        person_yearly_income numeric,
        total_debt numeric,
        fico_score integer,
        num_credit_cards integer
    );
alter table dummy_db.public.users
add primary key (user);
create stage user_temp file_format = (type = csv);
put 'file:///opt/airflow/dags/data/users.csv' @user_temp auto_compress = true;
copy into dummy_db.public.users
from @user_temp file_format = (type = csv) on_error = 'skip_file';