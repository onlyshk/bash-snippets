#!usr/bin/shell

function join () {
	local sep=$1
	shift
	builtin echo "$1$(shift ; for x do builtin echo -n "$sep$x"; done)";
}

