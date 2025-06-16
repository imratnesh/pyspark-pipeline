# Apache Hive Setup and Usage Guide

This document provides instructions for setting up and using Apache Hive with Hadoop.

## Prerequisites

- Hadoop cluster up and running
- Java 8 (recommended) or Java 11
- Hive installed and configured

## Configuration

### Core Configuration Files

1. **hive-site.xml**
   ```xml
   <configuration>
     <property>
       <name>hive.metastore.warehouse.dir</name>
       <value>/user/hive/warehouse</value>
     </property>
     <property>
       <name>hive.server2.enable.doAs</name>
       <value>false</value>
     </property>
     <property>
       <name>metastore.event.db.notification.api.auth</name>
       <value>false</value>
     </property>
   </configuration>
   ```

2. **hivemetastore-site.xml**
   ```xml
   <configuration>
     <property>
       <name>javax.jdo.option.ConnectionURL</name>
       <value>jdbc:derby:;databaseName=/opt/hive/metastore_db;create=true</value>
     </property>
     <property>
       <name>javax.jdo.option.ConnectionDriverName</name>
       <value>org.apache.derby.jdbc.EmbeddedDriver</value>
     </property>
   </configuration>
   ```

## Starting Hive Services

1. **Initialize Derby Metastore (first time only)**
   ```bash
   schematool -dbType derby -initSchema
   ```

2. **Start Hive Metastore**
   ```bash
   nohup hive --service metastore > /tmp/hive-metastore.log 2>&1 &
   ```

3. **Start HiveServer2**
   ```bash
   nohup hive --service hiveserver2 > /tmp/hive-hiveserver2.log 2>&1 &
   ```
   
## Basic Hive Commands

### Connect to Hive

```bash
# Using Beeline
beeline -u jdbc:hive2://localhost:10000

# Using Hive CLI (deprecated in newer versions)
hive
```

### Database Operations

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS mydb;

-- Show databases
SHOW DATABASES;

-- Use database
USE mydb;
```

### Table Operations

```sql
-- Create table
CREATE TABLE IF NOT EXISTS employees (
    id INT,
    name STRING,
    salary FLOAT,
    department STRING
) 
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- Load data from HDFS
LOAD DATA INPATH '/user/hadoop/employees.csv' INTO TABLE employees;

-- Query data
SELECT * FROM employees;
SELECT department, AVG(salary) as avg_salary 
FROM employees 
GROUP BY department;
```

### External Tables

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS sales (
    id INT,
    product STRING,
    amount FLOAT,
    sale_date DATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
LOCATION '/user/hive/warehouse/sales';
```

## Troubleshooting

### Common Issues

1. **Metastore Connection Issues**
   - Verify metastore is running: `jps | grep -i metastore`
   - Check logs: `tail -f /tmp/hive-metastore.log`

2. **Permission Issues**
   ```bash
   # Set proper permissions on HDFS
   hadoop fs -chmod -R 777 /user/hive/warehouse
   ```

3. **HiveServer2 Connection Refused**
   - Verify HiveServer2 is running: `jps | grep -i hiveserver2`
   - Check logs: `tail -f /tmp/hive-hiveserver2.log`

## Useful Configuration Parameters

| Parameter | Description | Recommended Value |
|-----------|-------------|-------------------|
| hive.metastore.uris | URI for Hive Metastore | thrift://localhost:9083 |
| hive.server2.thrift.port | HiveServer2 port | 10000 |
| hive.exec.scratchdir | Directory for temporary files | /tmp/hive-${user.name} |
| hive.metastore.warehouse.dir | Default warehouse location | /user/hive/warehouse |

## Performance Tuning

1. **Enable Tez Execution Engine**
   ```sql
   SET hive.execution.engine=tez;
   ```

2. **Enable Vectorization**
   ```sql
   SET hive.vectorized.execution.enabled=true;
   SET hive.vectorized.execution.reduce.enabled=true;
   ```

3. **Partitioning**
   ```sql
   CREATE TABLE sales_partitioned (
       id INT,
       product STRING,
       amount FLOAT
   )
   PARTITIONED BY (sale_date DATE);
   ```

## Backup and Recovery

### Export Database
```bash
# Export DDL
hive -e "SHOW CREATE DATABASE mydb" > mydb_ddl.hql

# Export data (using HDFS commands)
hadoop fs -get /user/hive/warehouse/mydb ./mydb_backup
```

### Import Database
```bash
# Create database
hive -e "CREATE DATABASE mydb_restored;"

# Import data
hadoop fs -put ./mydb_backup/* /user/hive/warehouse/mydb_restored/
```

## Security

1. **Enable Hive Authorization**
   ```sql
   SET hive.security.authorization.enabled=true;
   SET hive.users.in.admin.role=admin;
   ```

2. **Grant Permissions**
   ```sql
   GRANT SELECT ON DATABASE mydb TO USER username;
   GRANT ALL ON TABLE mytable TO USER username;
   ```

## Resources

- [Apache Hive Documentation](https://cwiki.apache.org/confluence/display/Hive/Home)
- [Hive Language Manual](https://cwiki.apache.org/confluence/display/Hive/LanguageManual)
- [Hive Configuration Properties](https://cwiki.apache.org/confluence/display/Hive/Configuration+Properties)
