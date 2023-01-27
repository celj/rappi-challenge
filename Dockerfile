FROM apache/airflow:2.5.1
RUN pip install requests
RUN pip install pandas