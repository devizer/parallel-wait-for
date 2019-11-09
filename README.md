## parallel-wait-for
Cross-platform tool for CI &amp; testing using external dependencies

#### ./WaitFor [-Timeout=second]

It's a console app which intended to check initialization of dependencies. It supports native protocols of 9+ kinds of storage/APIs:
* MSSQL Server
* Postgres SQL
* MySQL
* Oracle
* MongoDB
* Cassandra
* RabbitMQ
* Redis
* Http
* Tcp

`./WaitFor` app supports parameters via both command line and environment variobales. 
This example will check two RDBMS server: SQLServer sqlserver1 and MySQL mysql1

```
WAIT_FOR_MySQL="Server = mysql1; Port=3306; Uid = root; Pwd = your_password; Connect Timeout = 5" \
./WaitFor -Timeout=60 "-MSSQL=Data Source=sqlserver1; User ID=sa; Password=your_password; Timeout = 5"
```
#### Installer for linux: [install-parallel-wait-for.sh](https://raw.githubusercontent.com/devizer/parallel-wait-for/master/install-parallel-wait-for.sh)
It is `sh`-freendle. bash is not required.

It supports almost any **x64/arm/arm64** Linux and macOS 10.12+. The oldest supported versions of linux are: CentOS/RedHat 6, Debian 8, Ubuntu 14.04, Fedora 26

It utilizes either `curl` or `wget` depending what is preinstalled on your linux during installation

#### http
Along with basic http(s) check it allows to specify:
* check or ignore https certificates: `Allow Untrusted: true|false;`
* specify valid status codes. for example `Valid Status: 200;` or `Valid Status: 42,100-399`;
* check for a REST API endpoint, for example
```
http://mywebapi:80/get-status; Valid Status=200,403,100-499; Allow Untrusted = true; Method=POST; *Accept=application/json, text/javascript; Payload={'verbosity':'normal'}"
```

By default an self-signed certificate is allowed and valid statuses are 100-399

#### Source Code
https://github.com/devizer/DockerLab
