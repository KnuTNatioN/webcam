#!/bin/bash

#extra skript fuer Zeitraffer

			# 1. Datum generieren: YYYY-MM-DD_hh-mm-ss
			# 2. count_name in Dateiname einfuegen
			# 3. Kopie von lastest.jpg Lokal mit %wert.jpg in ~/timelaps/ speichern
			# 4. Kopie auf Server uploaden

# 1. Datum generieren: YYYY-MM-DD_hh-mm-ss
count_name=`date +"%Y-%m-%d_%H-%M-%S"`

# 2. $wert in Dateiname einfuegen
path_photo_local="/home/pi/cam/latest.jpg"
path_photo_online="/path/on/server/for/latest.jpg"

path_photo_ongoing="/home/pi/cam/timelaps/$count_name.jpg"
path_photo_ongoing_online="/path/on/server/for/timelaps/$count_name.jpg"


# 3. Kopie von deimos.jpg Lokal mit %count_name.jpg in ~/bau/ speichern
cp $path_photo_local $path_photo_ongoing


# 4. Kopie auf Server uploaden
	#/home/pi/.ssh/id_ed25519 ist der Pfad zum Private Key
scp -C -i/home/pi/.ssh/id_ed25519 $path_photo_ongoing name@server.example:$path_photo_ongoing_online
