{ pkgs }:

pkgs.writeShellApplication {

	name = "tkeyboard";
	text = ''
			# Try to detect the built-in keyboard by looking for known patterns
			KEYBOARD_ID=$(xinput list | grep -Ei 'AT Translated Set 2 keyboard|internal keyboard|builtin keyboard' | grep -o 'id=[0-9]*' | grep -o '[0-9]*')

			# Check if the built-in keyboard ID was found
			if [ -z "$KEYBOARD_ID" ]; then
				echo "Built-in keyboard not found."
				exit 1
			fi

			# Check the current state of the keyboard (enabled=1, disabled=0)
			STATE=$(xinput list-props "$KEYBOARD_ID" | grep "Device Enabled" | awk '{print $4}')

			# Ensure STATE is a number to avoid errors
			if ! [[ "$STATE" =~ ^[0-9]+$ ]]; then
				echo "Unable to retrieve the current state of the built-in keyboard."
				exit 1
			fi

			# Toggle the keyboard state
			if [ "$STATE" -eq 1 ]; then
				xinput disable "$KEYBOARD_ID"
				echo "Built-in keyboard disabled."
			else
				xinput enable "$KEYBOARD_ID"
				echo "Built-in keyboard enabled."
			fi
	'';

}
