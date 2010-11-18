#!usr/bin/shell

function split () {
	local IFS="$1"
	builtin echo $(for x in $2; do builtin echo -n "$x "; done);
}

