## parallel-wait-for
Cross-platform tool for CI &amp; testing using external dependencies

#### ./WaitFor [-Timeout=second]

It's a sandbox app which intended to check initialization of storage services. It supports native protocols of 5 kinds of storage/APIs:
* MSSQL Server
* Postgres SQL
* MySQL
* Oracle
* MongoDB
* Cassandra
* RabbitMQ
* Redis
* Http

`./WaitFor` app supports parameters via both command line and environment variobales. 
This example will check two RDBMS server: SQLServer sqlserver1 and MySQL mysql1

```
WAIT_FOR_MySQL="Server = mysql1; Port=3306; Uid = root; Pwd = your_password; Connect Timeout = 5" \
./WaitFor -Timeout=60 "-MSSQL=Data Source=sqlserver1; User ID=sa; Password=your_password; Timeout = 5"
```

#### Source Code
https://github.com/devizer/DockerLab
