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
`sed -n '16224,16482p;16483q' source > target` | Print lines 16224-16482 (inclusive, 1-based)
`iptstate` | Show open ports/connections
`... | xargs -I {} echo "{} is the item"` | Use `-I {}` to define a placeholder. This implies `-L 1` (1 argument per command line).
`wget --no-host-directories --force-directories --input-file=urls.txt` | Download a list of URLs, keeping the directory structure


Safe replacement with `sed`
`sed -e 's/mandrake.rz01.deposit-solutions.com/git.prod.infra.deposit/g' index.html > index.html.tmp && mv index.html.tmp index.html`
--> here is a shell function to replace literal (non-regex) lines in a file safely:
```sh
function replace_line_in_file() {
  if [[ "$#" -lt 3 ]]; then echo "Usage: $0 <search> <replace> <file>"; exit 1; fi
  local search="$1"
  local replace="$2"
  local file="$3"

  grep -Fxq "$search" "$file" || return 1
  sed -e "s/^$search\$/$replace/" "$file" > "$file.tmp" && mv "$file.tmp" "$file"
}
```

Sort the words of each line in a file alphabetically:
```python
#!/usr/bin/env python3

import fileinput

for line in fileinput.input():
    words = line.split()
    sorted_words = sorted(words)
    print(' '.join(sorted_words))
```

`wrk` (https://github.com/wg/wrk) can be used to load-test APIs
Example: `wrk -t2 -c100 -d60s -U -R2000 htttp://localhost/my/api`
