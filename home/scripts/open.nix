{ pkgs }:

pkgs.writeShellApplication {

	name = "open";
	runtimeInputs = [ pkgs.xdg-utils ];

	text = ''
		if [ -z "$1" ]; then
				echo "Usage: $0 <file_or_url>"
				exit 1
		fi
		nohup xdg-open "$1" >/dev/null 2>&1 &
	'';

}
