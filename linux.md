# Linux commands

Command | Description
--- | ---
`xdg-open` | Open a file with the default desktop program
`cat lines.txt | sed "s/\(.*\)/\"\1\"/"` | Wrap all lines in a file in quotes
`xxd <file>` | View hex
`sudo update-alternatives --config java` | Choose Java version
`kill -3 <pid>` | Thread dump of Java process
`adduser -c"User's Name" -g"default_group" -m username`<br>`-m` creates the home directory<br>Add `-n` to prevent creating a private group for the user<br>Use `-s` to set the login shell | Add a user
`grep -l` | Only show filename of matching files (`grep -irl` hehe)
`diff -qNr` | Compare two directory trees (`-N` also includes files that may not exist in either directory)
`ncdu` | Tree-based disk space viewer
`tail -n+1` | Skip first line

Safe replacement with `sed`
sed -e 's/mandrake.rz01.deposit-solutions.com/git.prod.infra.deposit/g' index.html > index.html.tmp && mv index.html.tmp index.html

`wrk` (https://github.com/wg/wrk) can be used to load-test APIs
Example: `wrk -t2 -c100 -d60s -U -R2000 htttp://localhost/my/api`
