#!/bin/bash

TARGET=./incoming/
PROCESSED=./processed

inotifywait -m -e create -e moved_to --format "%f" $TARGET \
        | while read FILENAME
                do
			sleep 10
                        echo Detected $FILENAME, moving 
                        mv "$TARGET/$FILENAME" "$PROCESSED/$FILENAME"
			echo "$FILENAME"
			if [[ $FILENAME == *.epub ]]
			then
				echo "epub file, emailing"
				echo $FILENAME | mail -s "EBOOK" $1 -A $PROCESSED/"$FILENAME"  # pass email address of kindle as argument to the script
			fi
                done
