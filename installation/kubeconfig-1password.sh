#!/bin/bash
#
# Download Kubernetes cluster configs from 1Password and merge them.
#
# ARG_HELP([Download Kubernetes cluster configs from 1Password and merge them])
# ARG_POSITIONAL_SINGLE([op-account],[The 1Password account id],[])
# ARG_POSITIONAL_SINGLE([op-vault],[The 1Password vault uuid],[])
# ARGBASH_GO()
# needed because of Argbash --> m4_ignore([
### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate


die()
{
	local _ret="${2:-1}"
	test "${_PRINT_HELP:-no}" = yes && print_help >&2
	echo "$1" >&2
	exit "${_ret}"
}


begins_with_short_option()
{
	local first_option all_short_options='h'
	first_option="${1:0:1}"
	test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
# THE DEFAULTS INITIALIZATION - OPTIONALS


print_help()
{
	printf '%s\n' "Download Kubernetes cluster configs from 1Password and merge them"
	printf 'Usage: %s [-h|--help] <op-account> <op-vault>\n' "$0"
	printf '\t%s\n' "<op-account>: The 1Password account id"
	printf '\t%s\n' "<op-vault>: The 1Password vault uuid"
	printf '\t%s\n' "-h, --help: Prints help"
}


parse_commandline()
{
	_positionals_count=0
	while test $# -gt 0
	do
		_key="$1"
		case "$_key" in
			-h|--help)
				print_help
				exit 0
				;;
			-h*)
				print_help
				exit 0
				;;
			*)
				_last_positional="$1"
				_positionals+=("$_last_positional")
				_positionals_count=$((_positionals_count + 1))
				;;
		esac
		shift
	done
}


handle_passed_args_count()
{
	local _required_args_string="'op-account' and 'op-vault'"
	test "${_positionals_count}" -ge 2 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require exactly 2 (namely: $_required_args_string), but got only ${_positionals_count}." 1
	test "${_positionals_count}" -le 2 || _PRINT_HELP=yes die "FATAL ERROR: There were spurious positional arguments --- we expect exactly 2 (namely: $_required_args_string), but got ${_positionals_count} (the last one was: '${_last_positional}')." 1
}


assign_positional_args()
{
	local _positional_name _shift_for=$1
	_positional_names="_arg_op_account _arg_op_vault "

	shift "$_shift_for"
	for _positional_name in ${_positional_names}
	do
		test $# -gt 0 || break
		eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
		shift
	done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])
# [ <-- needed because of Argbash

# Back up your current kubeconfig
now=$(date --iso=second)
if [ -e $HOME/.kube/config ]; then
    mv $HOME/.kube/config{,.bak-$now}
fi

# Log into 1Password
eval $(op signin $_arg_op_account)

# Download and write all configurations
mkdir -p $HOME/.kube/config.d
for uuid in $(op list items --vault $_arg_op_vault | jq '.[].uuid' --raw-output); do
    title=$(op get item $uuid | jq '.overview.title' --raw-output)
    if [[ $(echo "$title" | grep "kubeconfig: oidc") ]]; then
        name=$(echo "$title" | cut -d' ' -f2)
        echo "Getting $name"
        op get item $uuid | jq '.details.sections[0].fields[] | select(.t=="~/.kube/config").v' --raw-output > $HOME/.kube/config.d/$name
    else
        echo "Skipping $title"
    fi
done
echo "Generating merged kubeconfig"
kubeconfigs=""
for f in $(ls $HOME/.kube/config.d); do
    kubeconfigs+="$HOME/.kube/config.d/$f:"
done
KUBECONFIG=$kubeconfigs kubectl config view --flatten > $HOME/.kube/config
echo "Setting permissions"
chmod 600 $HOME/.kube/config
echo "Done"

# ] <-- needed because of Argbash
