#!/bin/bash

# 1	Foto aufnehmen
# 2	warten auf Foto gespeichert
# 3	Foto auf Server Uploaden

path_photo_local="/home/pi/cam/latest.jpg"
path_photo_online="/path/on/server/for/latest.jpg"

#Foto machen
	#Tag-verion
raspistill -q 100 -ex auto -w 1640 -h 1232 -o $path_photo_local
	#Nacht-version
#raspistill -q 100 -ex night -w 1640 -h 1232 -o $path_photo_local

sleep 10s	#wartezeit fuer Foto...

#upload
	#/home/pi/.ssh/id_ed25519 ist der Pfad zum Private Key
scp -C -i/home/pi/.ssh/id_ed25519 $path_photo_local name@server.example:$path_photo_online
