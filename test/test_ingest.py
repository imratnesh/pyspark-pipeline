import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from pipeline import ingest, persist
from pyspark.sql import SparkSession

def test_ingest_data():
    spark = SparkSession.builder\
            .appName("Test Pipeline Spark")\
            .config("spark.driver.extraClassPath","pipeline/postgresql-42.2.18.jar")\
            .enableHiveSupport().getOrCreate()
    ingest_process = ingest.Ingest(spark)
    # ingest_process.read_from_pg()
    ingest_process.read_from_pg_using_jdbc_driver()
    df = ingest_process.ingest_data()
    assert df is not None
    persist_process = persist.Persist(spark)
    persist_process.insert_into_pg()
    # persist_process.persist_data(df)
    print(df.show())

if __name__ == "__main__":
    test_ingest_data()
