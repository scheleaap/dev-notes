# Snowflake

## Snow CLI

My version:
```sh
snowflake_version=$(curl -sS "https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/index.html" | grep index.html | sed -E 's/^.*<p style="display: none">(.*)<\/p>.*$/\1/' | grep -v "\.\." | sort -V | tail -n1
)
curl -LsS "https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/${snowflake_version}/snowflake-cli-${snowflake_version}.x86_64.deb" -o "snowflake-cli-${snowflake_version}.x86_64.deb"
sudo dpkg -i "snowflake-cli-${snowflake_version}.x86_64.deb"
```

Claude's version:
```sh
snowflake_version=$(curl -s https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/index.html | grep -o '[0-9]\+\.[0-9]\+\.[0-9]\+' | sort -V | tail -1)
wget -O "snowflake-cli-${snowflake_version}.x86_64.deb" "https://sfc-repo.snowflakecomputing.com/snowflake-cli/linux_x86_64/${snowflake_version}/snowflake-cli-${snowflake_version}.x86_64.deb"
sudo dpkg -i "snowflake-cli-${snowflake_version}.x86_64.deb"
```

## ODBC driver

Source: https://docs.snowflake.com/en/developer-guide/odbc/odbc-linux

1. Download and install the driver and its dependencies
    ```sh
    snowflake_odbc_version=3.12.0
    sf_account="orgyborgy-prod"
    curl -LsS "https://sfc-repo.snowflakecomputing.com/odbc/linux/${snowflake_odbc_version}/snowflake-odbc-${snowflake_odbc_version}.x86_64.deb" -o "snowflake-odbc-${snowflake_odbc_version}.x86_64.deb"
    sudo apt install odbcinst unixodbc
    sudo dpkg -i "snowflake-odbc-${snowflake_odbc_version}.x86_64.deb"
    ```
1. The Snowflake driver may be configured for `libodbcinst.so.1` but Ubuntu 22.04+ uses version 2. Fix this by updating the driver configuration:
    ```sh
    sudo sed -i 's|libodbcinst.so.1|libodbcinst.so.2|' /usr/lib/snowflake/odbc/lib/simba.snowflake.ini
    ```
1. _(Optional)_ Configure a ODBC data source by creating `~/.odbc.ini` with your Snowflake connection details:
    ```ini
    [ODBC Data Sources]
    Snowflake = SnowflakeDSIIDriver

    [Snowflake]
    Driver = SnowflakeDSIIDriver
    Description = Snowflake ODBC Connection
    Server = <your-account>.snowflakecomputing.com
    uid = <your-username>
    authenticator = snowflake_jwt
    priv_key_file = /path/to/your/private_key.p8

    # Optional: Specify if needed
    # Database = <your-database>
    # Schema = <your-schema>
    # Warehouse = <your-warehouse>
    # Role = <your-role>

    # Performance settings
    CLIENT_SESSION_KEEP_ALIVE = true
    ```
1. _(Alternative)_ Provide the connection details in Python:
    ```python
    import pyodbc

    conn_str = (
        "Driver=SnowflakeDSIIDriver;"
        "Server=audiomee-prod.snowflakecomputing.com;"
        "uid=wout;"
        "authenticator=snowflake_jwt;"
        "priv_key_file=/home/wout/Documents/keys/snowflake_wout_rsa_key.p8;"
        "warehouse=DEFAULT2;"
    )

    connection = pyodbc.connect(conn_str, autocommit=True)
    ```
