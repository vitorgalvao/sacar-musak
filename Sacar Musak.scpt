if (((clipboard info) as text) contains string) and ((the clipboard) starts with "http") then
	set grabbedURL to (the clipboard)
else
	set grabbedURL to ""
end if

set scriptsDir to POSIX path of (path to resource "Scripts")
set dialogResult to (display dialog "Link to download" with title "Sacar Musak" default answer grabbedURL buttons {"Cancel", "Sound", "Video"} default button "Video" with icon (path to resource "applet.icns"))
set theURL to the text returned of dialogResult
set theButton to the button returned of dialogResult
set theTitle to (do shell script "PATH=\"/usr/local/bin:" & scriptsDir & ":${PATH}\" && youtube-dl --get-title " & quoted form of theURL)

if theButton is "Sound" then
	set theOptions to "--audio-format mp3 --extract-audio "
else
	set theOptions to ""
end if

do shell script "PATH=\"/usr/local/bin:" & scriptsDir & ":${PATH}\" && cd \"${HOME}/Desktop\" && youtube-dl " & theOptions & quoted form of theURL

display notification theTitle with title "Downloaded " & theButton sound name "Glass"
do shell script "PATH=\"/usr/local/bin:" & scriptsDir & ":${PATH}\" && youtube-dl --update"
