import unittest
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))
from pipeline import transform
from pyspark.sql import SparkSession


class TransformTest(unittest.TestCase):
    def test_transform_should_replace_null_value (self):
        spark = SparkSession.builder \
            .appName("testing app") \
            .enableHiveSupport().getOrCreate()

        df = spark.read \
            .option("header", "true") \
            .option("inferSchema", "true") \
            .csv("test/mock_course_data.csv")

        df.show()

        tranform_process = transform.Transform(spark)
        transformed_df = tranform_process.transform_data(df)
        transformed_df.show()

        cms_author = transformed_df.filter("course_id='2'").select("author_name").collect()[0].author_name

        print("CMS Author name is " + str(cms_author))

        self.assertEqual("Unknown", str(cms_author))


if __name__ == '__main__':
    unittest.main()


