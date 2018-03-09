# Linux commands

Command | Description
- | -
`xdg-open` | Open a file with the default desktop program
`cat lines.txt | sed "s/\(.*\)/\"\1\"/"` | Wrap all lines in a file in quotes
`xxd <file>` | View hex
`sudo service mysql stop ; sudo killall -9 mysql ; sudo killall -9 mysqld ; sudo apt-get remove --purge mysql-server mysql-client mysql-common ; sudo apt-get autoremove ; sudo apt-get autoclean ; sudo deluser mysql ; sudo rm -rf /var/lib/mysql ; sudo rm -rf /var/log/mysql ; sudo rm -rf /etc/mysql` | Completely remove MySQL
`sudo update-alternatives --config java` | Choose Java version
`kill -3 <pid>` | Thread dump of Java process
`adduser -c"User's Name" -g"default_group" -m username`<br>`-m` creates the home directory<br>Add `-n` to prevent creating a private group for the user<br>Use `-s` to set the login shell | Add a user
`grep -l` | Only show filename of matching files (`grep -irl` hehe)
`diff -qNr` | Compare two directory trees (`-N` also includes files that may not exist in either directory)

Safe replacement with `sed`
sed -e 's/mandrake.rz01.deposit-solutions.com/git.prod.infra.deposit/g' index.html > index.html.tmp && mv index.html.tmp index.html

