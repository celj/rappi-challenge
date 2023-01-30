from airflow import DAG

# from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
from airflow.operators.python_operator import PythonOperator
import airflow
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

args = {
    "owner": "Airflow",
    "start_date": airflow.utils.dates.days_ago(2),
}

dag = DAG(
    dag_id="snowflake_automation",
    default_args=args,
    schedule_interval=None,
)


# def get_row_count(**context):
#     dwh_hook = SnowflakeHook(
#         snowflake_conn_id="snowflake_conn",
#     )
#     result = dwh_hook.get_first(
#         "select count(*) from public.users",
#     )
#     logging.info(
#         "Number of rows in `public.users`  - %s",
#         result[0],
#     )


with dag:
    create_insert = SnowflakeOperator(
        task_id="snowfalke_create",
        sql="sql/create_and_upload.sql",
        snowflake_conn_id="snowflake_conn",
    )

    # get_count = PythonOperator(
    #     task_id="get_count",
    #     python_callable=get_row_count,
    # )

# create_insert >> get_count

create_insert


# @dag(
#     dag_id="snowflake-automation",
#     schedule_interval="0 0 * * *",
#     start_date=pendulum.datetime(2022, 1, 1, tz="UTC"),
#     catchup=False,
#     dagrun_timeout=datetime.timedelta(minutes=60),
# )
# def ProcessData():
#     create_tables = PostgresOperator(
#         task_id="create_tables",
#         postgres_conn_id="snowflake_conn",
#         sql="sql/create_and_upload.sql",
#     )

#     @task
#     def get_data(csv_file):
#         data_path = f"/opt/airflow/dags/data/{csv_file}"

#         postgres_hook = PostgresHook(
#             postgres_conn_id="snowflake_conn",
#         )
#         conn = postgres_hook.get_conn()
#         cur = conn.cursor()
#         with open(data_path, "r") as file:
#             cur.copy_expert(
#                 "COPY employees_temp FROM STDIN WITH CSV HEADER DELIMITER AS ',' QUOTE '\"'",
#                 file,
#             )
#         conn.commit()

#     create_tables >> get_data("users.csv")


# dag = ProcessData()
