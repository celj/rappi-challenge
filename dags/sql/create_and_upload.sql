create or replace table dummy_db.public.cards_temp (
        user text,
        card_index text,
        card_brand text,
        card_type text,
        card_number text,
        expires text,
        cvv text,
        has_chip text,
        cards_issued text,
        credit_limit text,
        acct_open_date text,
        year_pin_last_changed text,
        card_on_dark_web text
    );
create or replace stage card_temp file_format = (type = csv);
put file:///opt/airflow/dags/data/cards.csv @card_temp auto_compress = true;
copy into dummy_db.public.cards_temp
from @card_temp file_format = (
        type = csv skip_header = 1 field_optionally_enclosed_by = '"'
    );
create or replace table dummy_db.public.transactions_temp (
        user text,
        card_index text,
        year text,
        month text,
        day text,
        time text,
        amount text,
        use_chip text,
        card_number text,
        merchant_city text,
        merchant_state text,
        zip text,
        mcc text,
        errors text,
        is_fraud text
    );
create or replace stage transaction_temp file_format = (type = csv);
put file:///opt/airflow/dags/data/transactions.csv @transaction_temp auto_compress = true;
copy into dummy_db.public.transactions_temp
from @transaction_temp file_format = (
        type = csv skip_header = 1 field_optionally_enclosed_by = '"'
    );
create or replace table dummy_db.public.users_temp (
        user text,
        person text,
        current_age text,
        retirement_age text,
        birth_year text,
        birth_month text,
        gender text,
        address text,
        apartment text,
        city text,
        state text,
        zip text,
        latitude text,
        longitude text,
        zip_income_per_capita text,
        person_yearly_income text,
        total_debt text,
        fico_score text,
        num_credit_cards text
    );
create or replace stage user_temp file_format = (type = csv);
put file:///opt/airflow/dags/data/users.csv @user_temp auto_compress = true;
copy into dummy_db.public.users_temp
from @user_temp file_format = (
        type = csv skip_header = 1 field_optionally_enclosed_by = '"'
    );