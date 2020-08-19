# Based on https://gregrs-uk.github.io/2018-11-01/open-files-neovim-iterm2-macos-finder/
on run {input, parameters}
	
	# seem to need the full path at least in some cases
	# -p opens files in separate tabs
	set nvimCommand to "/usr/local/bin/nvim -p "
	
	set filepaths to ""
	if input is not {} then
		repeat with currentFile in input
			set filepaths to filepaths & quoted form of POSIX path of currentFile & " "
		end repeat
	end if
	
	
	tell application "iTerm"
		create window with default profile
		tell current session of current window
			write text nvimCommand & filepaths
			split horizontally with default profile
			set columns to 150
			set rows to 50
		end tell
	end tell
end run
