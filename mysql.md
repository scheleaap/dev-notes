# MySQL / MariaDB

Command | Description
--- | ---
`sudo service mysql stop ; sudo killall -9 mysql ; sudo killall -9 mysqld ; sudo apt-get remove --purge mysql-server mysql-client mysql-common ; sudo apt-get autoremove ; sudo apt-get autoclean ; sudo deluser mysql ; sudo rm -rf /var/lib/mysql ; sudo rm -rf /var/log/mysql ; sudo rm -rf /etc/mysql` | Completely remove MySQL
`mysql --host localhost --port 3316 --user root --password=Dekaup10 --protocol=TCP comonea_b2c < *.sql` | Execute (multiple) SQL files
`mysql --host localhost --port 3316 --user root --password=Dekaup10 --protocol=TCP -e "SHOW TABLES;" comonea_b2c` | Execute SQL from the command line
