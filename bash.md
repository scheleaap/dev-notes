# Bash

Command | Description
- | -
`set -o errexit` | Exit immediately if a pipeline (or command) returns a non-zero status
`set -o pipefail` | Return the exit status of the last command in the pipe
`set -o nounset` | Treat unset variables and parameters as an error

Check the number of arguments:
```sh
function printUsageAndExit {
	echo "Usage: $0 HOSTNAME"
	exit 1
}

if [ $# -lt 1 ]; then
	printUsageAndExit
fi
```
