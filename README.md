# PySpark Pipeline

This project implements a data pipeline using PySpark for data ingestion and processing. It provides functionality to read data from various sources including PostgreSQL databases and CSV files, process the data using PySpark, and store the results.

## Features

- Data ingestion from multiple sources:
  - PostgreSQL database using JDBC
  - PostgreSQL database using pandas
  - Direct SQL queries to Spark
- Configurable logging system
- Modular pipeline architecture
- Support for both batch and streaming data processing

## Project Structure

```
pipeline/
├── ingest.py          # Data ingestion module
├── transform.py       # Data transformation module
├── persist.py         # Data persistence module
└── resources/
    ├── configs/
    │   ├── logging.conf  # Logging configuration
    │   └── pipeline.ini  # Pipeline configuration
    └── postgresql-42.2.18.jar  # PostgreSQL JDBC driver
```

## Prerequisites

- Python 3.8 or higher
- Apache Spark 3.5.0
- PostgreSQL 12 or higher
- Java 8 or higher (required for Spark)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/imratnesh/pyspark-pipeline.git
cd pyspark-pipeline
```

2. Create and activate a virtual environment (recommended):
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install the required dependencies:
```bash
pip install -r requirements.txt
```

## Configuration

1. PostgreSQL Setup:
   - Ensure PostgreSQL is running on localhost:5432
   - Default credentials (modify as needed):
     - Username: postgres
     - Password: xxxx
     - Database: postgres
   - Create required schemas and tables:
     - Use the provided SQL script to create schemas and tables:
       ```bash
       psql -U postgres -d postgres -f CREATE_TABLES.sql
       ```
     - This will create:
       - futurexschema.futurex_course_catalog
       - fxxcoursedb.fx_course_table

2. Logging Configuration:
   - Logging settings are in `pipeline/resources/configs/logging.conf`
   - Adjust log levels and output paths as needed

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

## Verification / Quickstart

After installation and configuration, verify your setup:

1. Check Python dependencies:
```bash
pip list | grep -E "pyspark|psycopg2|pandas"
```

2. Check Spark and Java installation:
```bash
spark-submit --version
java -version
```

3. Check PostgreSQL connection and tables:
```bash
psql -U postgres -d postgres -c "\dt futurexschema.*"
psql -U postgres -d postgres -c "\dt fxxcoursedb.*"
```

4. Run a sample pipeline ingestion (from Python shell):
```python
from pipeline.ingest import Ingest
from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Pipeline").getOrCreate()
ingest = Ingest(spark)
df = ingest.ingest_data()
print(df.show())
```

If you see a DataFrame output, your setup is correct!

## Development

- Follow PEP 8 style guide for Python code
- Ensure proper logging is implemented for all operations
- Test database connections before running the pipeline
- Use type hints for better code maintainability
- Write unit tests for new features

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request


## Screenshots

### Screenshot 1: HiveServer2 Web UI or Beeline Connection

![Screenshot 1 - TODO: Insert HiveServer2 Web UI or Beeline Connection image here](txt_commands/hadoop_ui.png)

### Screenshot 2: Hive Query Result Example

![Screenshot 2 - TODO: Insert Hive Query Result Example image here](txt_commands/hive_ui.png)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Connect with Me

- LinkedIn: [Ratnesh Kushwaha](http://linkedin.com/in/ratneshkushwaha/)
- YouTube: [India Analytica](https://www.youtube.com/@IndiaAnalytica)

## Support
[REF](https://github.com/futurexskill/bigdata)
For support, please open an issue in the GitHub repository or contact the maintainers. 