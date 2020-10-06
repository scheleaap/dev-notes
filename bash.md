# Bash

Command | Description
--- | ---
`set -o errexit` | Exit immediately if a pipeline (or command) returns a non-zero status
`set -o pipefail` | Return the exit status of the last command in the pipe
`set -o nounset` | Treat unset variables and parameters as an error
`[[ ":$PATH:" != *":$HOME/.local/bin:"* ]] && PATH="$HOME/.local/bin:${PATH}"` | Add `$HOME/.local/bin` to the `$PATH` if it is not on it

Check the number of arguments:
```sh
function usage {
	echo "Usage: $0 HOSTNAME"
}

if [ $# -lt 1 ]; then
	usage
	exit 1
fi
```
