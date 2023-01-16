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
				echo $FILENAME | mail -s "EBOOK" arihantchawla.becse17_GMat9r@kindle.com  -A $PROCESSED/"$FILENAME"
			fi
                done
