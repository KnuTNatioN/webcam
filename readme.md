# Webcam stuff or s.th.
## 2 small bash scripts to make a picture and out of this a timelaps video
### Pre-work:
- Raspberry Pi 
- updated raspbian (tested: June-2020)
- real Hardware-Webcam and enabled webcam in raspi-config
- electric Power
- a motive for which it is worth wasting electricity.
- kind of motivation

### Lazy as a teddybear
I am quite lazy and do the pictures with a simple Crontab:

`crontab -e`

take the picture

`1-59/2 5-21 * * * bash foto.sh >/dev/null 2>&1`

store a copy every x minutes

`*/15 6-17 * 6-7 1-6 bash raffer.sh >/dev/null 2>&1`

##### A short explanation of my recording times:
I only have pictures during the day because I want to make a time lapse video of the construction site behind my house. The construction workers rarely work at night and the Raspberry cam has a night setting, but not the best night vision.

so: Mondays - Saturdays

in each case from 6-17 o'clock

Because this is a house that is being built, I only take a picture every 15 minutes for the time lapse.

But every 2 minutes I take a live picture

### Script1: **foto.sh**
**takes a photo with raspistill**
[Raspistill- dokumentation](https://www.raspberrypi.org/documentation/usage/camera/raspicam/raspistill.mdhttp:// "Raspistill- dokumentation")

*DayVision:

`raspistill -q 100 -ex auto -w 1640 -h 1232 -o $save-path`*

*NightVision:

`raspistill -q 100 -ex night -w 1640 -h 1232 -o $save-path`*

* -q 100 =jpeg quality (100%)
* -ex auto =Automatic photo settings, because I do not know much about photo technology.
* -w =width
* -h =height

> I have halved the number of pixels to keep the camera running longer with my 4GB memory card

The Saving:

`sleep(10s)`

>Because the Pi Zero W sometimes didn't save the picture correctly, I added a 10 second waiting time.
At full screen I had a waiting time of 30 seconds.
So at fullscreen the max safety fps is **0.0333fps**.

now the Uploading part to a server

`scp -C -i/excryptionPrivateKeyPath /source/of/picture.jpg user@example.server:/destination/path/of/`

### Script2: **raffer.sh**
First build a Filename... lets take the date with time

` count_name= date +"%Y-%m-%d_%H-%M-%S" ` (**Change the tic after= to a right-tic!**)

>looks like: 2020-06-22_13-49-42.jpg
>based on the class system, I build the paths beforehand. so you can adjust the sktipt better.

make a local copy of the latest picture:

`cp $path_photo_local $path_photo_ongoing`

save a copy of the local copy on the Fileserver: ak: Upload

`scp -C -i/excryptionPrivateKeyPath /source/of/picture.jpg user@example.server:/destination/path/of/`

>I upload the copy to the file-server so that I don't have any differences between the continuous files locally and server. Because in the time between local copy and server upload, maybe and possibly a new version of the picture can be made. (after all, there are 2 scripts and as I said, I am lazy!)

### Align the camera:

>Since the raspi camera and software support a video stream, I set up my laptop with VLC player and pi video stream for aligning the camera: (type in terminal of Raspberry Pi)

*192.168.42.24* is YOUR local IP Adress OF THE RASPI! with PORT:5000

`raspivid -t 0 -ex night -w 640 -h 360 -fps 20 -l -o tcp://192.168.42.24:5000`

VLC: *Open network Stream* :

`tcp/h264://192.168.42.24:5000`

#### the time I've invested in this project:
- 40min of code writing and wondering why *raspistill* doesn't use only ONE F"?$%&/ing "l"
- 30 minutes Align camera
- 2 hours typing this documentation
- Hotel-Trivago
- The lazy Teddybear commented his Code in German/English mixup. This simple doku should be enough. =)

### THANKS TO helper Software things and so on:
- Translated with [www.DeepL.com/Translator](www.DeepL.com/Translator "www.DeepL.com/Translator") (free version)
- [markDown generator (still lazy)](https://pandao.github.io/editor.md/en.html "markDown generator (still lazy)")

#### Last words:
>I think this is a perfect example of how to completely overdo documentation for such a simple script.

-fin-
