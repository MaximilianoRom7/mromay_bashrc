. $home/mromay_bashrc/imports.sh
import logging

function video_folder_to_mp3() {
    : '
    THIS FUNCTION CONVERTS ALL THE .MP4 FILES
    IN THE CURRENT FOLDER TO .MP3 USSING FFMPEG
    '
    ls *.mp4 | while read l
    do
	f=$(sed 's/\.mp4$/\.mp3/g' <<< "$l")
	if [ $(egrep "\.mp3$" <<< "$f") ] && [ ! -f "$f" ]
	then
	    echo ffmpeg -nostdin -i "$l" "$f" -nostats -loglevel 0
	    ffmpeg -nostdin -i "$l" "$f" -nostats -loglevel 0
	else
	    echo "EXISTS: $f"
	fi
    done
}

loaded video
