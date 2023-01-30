use role securityadmin;
create or replace role dummy_dev_role comment = 'dummy_dev_role';
use role accountadmin;
grant role dummy_dev_role to role sysadmin;
create or replace user dummy_user password = 'password' default_role = dummy_dev_role default_warehouse = dummy_wh comment = 'dummy user';
grant role dummy_dev_role to user dummy_user;
use role accountadmin;
grant create database on account to role dummy_dev_role;
use role sysadmin;
create or replace warehouse dummy_dev_wh with warehouse_size = 'xsmall' auto_suspend = 120 auto_resume = true initially_suspended = true;
grant all on warehouse dummy_dev_wh to role dummy_dev_role;
use role accountadmin;
create or replace database dummy_db;
use role accountadmin;
grant all on database dummy_db to role dummy_dev_role;
use role accountadmin;
grant all on schema dummy_db.public to role dummy_dev_role;