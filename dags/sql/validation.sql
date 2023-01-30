-- this is just an example of modifications that can be made to the data
-- here, the other tables will not be modified
create or replace table dummy_db.public.cards as (
        select user,
            card_index,
            card_brand,
            card_type,
            card_number,
            expires,
            cvv,
            has_chip::boolean as has_chip,
            cards_issued,
            replace(credit_limit, '$', '')::numeric as credit_limit,
            acct_open_date,
            year_pin_last_changed,
            card_on_dark_web::boolean as card_on_dark_web
        from dummy_db.public.cards_temp
    );
create or replace table dummy_db.public.transactions as (
        select *
        from dummy_db.public.transactions_temp
    );
create or replace table dummy_db.public.users as (
        select *
        from dummy_db.public.users_temp
    );
alter table dummy_db.public.cards
add primary key (user, card_number);
alter table dummy_db.public.transactions
add primary key (
        user,
        card_index,
        year,
        month,
        day,
        time,
        amount
    );
alter table dummy_db.public.users
add primary key (user);
drop table dummy_db.public.cards_temp;
drop table dummy_db.public.transactions_temp;
drop table dummy_db.public.users_temp;
alter table dummy_db.public.cards
add foreign key (user) references dummy_db.public.users (user);
alter table dummy_db.public.transactions
add foreign key (user) references dummy_db.public.users (user);