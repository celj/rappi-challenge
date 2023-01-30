# Challenge for Data Engineer position at Rappi

## Setup

1. First, let's go to the Snowflake console and run the script `snowflake-setup.sql`. This creates a dummy role, our warehouse, and database.

2. For replication, you need to set `default:outputs:dev:acoount` to your own `<ACCOUNT_URL>.<REGION>` in [`dbt/profiles.yml`](dbt/profiles.yml). Since I am in a trial account, my settings are `default:outputs:dev:acoount: sl22983.us-central1`.
