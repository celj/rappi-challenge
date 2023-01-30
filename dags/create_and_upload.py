from airflow import DAG
from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator
import airflow
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

args = {
    "owner": "Airflow",
    "start_date": airflow.utils.dates.days_ago(0),
}

dag = DAG(
    dag_id="snowflake_automation",
    default_args=args,
    schedule_interval=None,
)

with dag:
    create_and_upload = SnowflakeOperator(
        task_id="create_and_upload",
        sql="sql/create_and_upload.sql",
        snowflake_conn_id="snowflake_conn",
    )

    validation = SnowflakeOperator(
        task_id="validation",
        sql="sql/validation.sql",
        snowflake_conn_id="snowflake_conn",
    )

create_and_upload >> validation
