## parallel-wait-for
Cross-platform tool for CI &amp; testing & single host deployment with external dependencies

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
Wait_For_Http_Google_404="https://google.com/404; Valid Status = 404; Timeout = 3" \
./WaitFor -Timeout=60 "-MsSql=Data Source=sqlserver1; User ID=sa; Password=your_password; Timeout = 5"
```

For connection string examples please take a look at `environment` sub tree of intergation tests via [docker-compose.yml](https://github.com/devizer/DockerLab/blob/master/compose/docker-compose.yml) on travis-ci.org

### Installer 
It is `sh`- and slim containers friendly. bash is not required.

It supports almost any **x64/arm/arm64** Linux and macOS 10.12+. The oldest supported versions of linux are: CentOS/RedHat 6, Debian 8, Ubuntu 14.04, Fedora 26

It utilizes either `curl` or `wget` depending what is preinstalled on your linux during installation. For https curl is required.

Link: [install-parallel-wait-for.sh](https://raw.githubusercontent.com/devizer/parallel-wait-for/master/install-parallel-wait-for.sh)

By default the installer extracts the parallel-wait-for to `/opt/parallel-wait-for` and creates symlink in `/usr/local/bin`

### http
Along with basic http(s) check it allows to specify:
* to validate or to ignore https certificates: `Allow Untrusted: true|false;`
* specify accecptable status codes. for example `Valid Status: 200;` or `Valid Status: 42,100-399`;
* check for a REST API endpoint, for example
```
parallel-wait-for -timeout=30 "-http=http://mywebapi:80/get-status; Valid Status=200,403,100-499; Allow Untrusted = true; Method=POST; *Accept=application/json, text/javascript; Payload={'verbosity':'normal'}"
```

By default an self-signed certificate is allowed and valid statuses are 100-399

### Source Code
https://github.com/devizer/DockerLab
