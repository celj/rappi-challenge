# Challenge for Data Engineer position at Rappi

## Setup

First, let's go to the Snowflake console and run the script `snowflake-setup.sql`. This creates a dummy role, our warehouse, and database, as well as the necessary permissions.

For replication, you need to start the containers with

```sh
docker-compose up --build && docker-compose up
```

All defaults were kept in this project, so airflow will be hosted at [`http://0.0.0.0:8080`](http://0.0.0.0:8080), and login keys are:

-   user: `airflow`
-   password: `airflow`

Before running the DAGs, establish your connection to Snowflake on `Admin > Connections` and select `Connection Type: Snowflake`. For compatibility, name your `Connection ID` as `snowflake_conn`. In my case, I used a trial version of Snowflake with the following keys (which will be deactivated in less than a week for security reasons):

-   Host: `https://sl22983.us-central1.gcp.snowflakecomputing.com`
-   Schema: `public`
-   Login: `dummy_user`
-   Password: `password`
-   Account: `sl22983`
-   Warehouse: `dummy_dev_wh`
-   Database: `dummy_db`
-   Region: `us-central1.gcp`
-   Role: `dummy_dev_role`

Most of these keys were set up previously by running `snowflake-setup.sql`. However, `host`, `account`, and `region` may be different if your using your own account.

Finally, go back to `DAGs` tab, and trigger the `snowflake_automation`[^1] DAG.

[^1]: Please note that this is a non-scheduled DAG.

To kill airflow and the containers, press `^C` and, then, run

```sh
docker-compose down --volumes --rmi all
```
