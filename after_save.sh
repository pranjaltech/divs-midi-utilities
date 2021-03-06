#!/bin/bash
while getopts f: flag
do
	case "${flag}" in
		f) filename=${OPTARG};;
	esac
done

echo "Saving" $filename

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"username": "midi-helper", "content": "MIDI File Captured. Saving... '${filename}'"}' \
  https://discord.com/api/webhooks/817323024348610611/3WiDRgTUXSe4mEE02gSecu0D6dIIy1hoaB9nJQ3y8df8140EJv0F647bKZGXb8z3Q7SX

rsync -azP --remove-source-files $HOME/midi-session-data/ pi@192.168.1.35:/home/pi/Titan/midi-session-data

curl --header "Content-Type: application/json" \
  --request POST \
  --data '{"username": "midi-helper", "content": "MIDI File Saved: '${filename}'"}' \
  https://discord.com/api/webhooks/817323024348610611/3WiDRgTUXSe4mEE02gSecu0D6dIIy1hoaB9nJQ3y8df8140EJv0F647bKZGXb8z3Q7SX
  
# Play Audio Ding
play $HOME/midi-utils/ding_g.mp3