# PySpark Pipeline

This project implements a data pipeline using PySpark for data ingestion and processing.

## Project Structure

```
pipeline/
├── ingest.py          # Data ingestion module
└── resources/
    └── configs/
        └── logging.conf  # Logging configuration
```

## Prerequisites

- Python 3.x
- Apache Spark
- PostgreSQL
- Required Python packages:
  - pyspark
  - psycopg2
  - pandas

## Setup

1. Install the required dependencies:
```bash
pip install pyspark psycopg2 pandas
```

2. Configure PostgreSQL connection:
   - Ensure PostgreSQL is running on localhost:5432
   - Default credentials (modify as needed):
     - Username: postgres
     - Password: admin
     - Database: postgres

3. Configure logging:
   - Logging configuration is available in `pipeline/resources/configs/logging.conf`

## Usage

The pipeline provides several methods for data ingestion:

1. Direct SQL query to Spark:
```python
from pipeline.ingest import Ingest
from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Pipeline").getOrCreate()
ingest = Ingest(spark)
df = ingest.ingest_data()
```

2. PostgreSQL ingestion using pandas:
```python
ingest.read_from_pg()
```

3. PostgreSQL ingestion using JDBC:
```python
ingest.read_from_pg_using_jdbc_driver()
```

## Development

- Follow PEP 8 style guide for Python code
- Ensure proper logging is implemented for all operations
- Test database connections before running the pipeline 