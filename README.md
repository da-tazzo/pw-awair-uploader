# pw-awair-uploader

This is a Docker image build for the community tool "awair-uploader" for PlanetWatch.

### many thanks ...
... to [Sheherezadhe](https://github.com/Sheherezadhe) for providing the [awair-uploader](https://github.com/Sheherezadhe/awair-uploader) community tool  
and to [accetto](https://github.com/accetto) for his [ubuntu-xfce-chromium image](https://github.com/accetto/headless-coding-g3/tree/master/docker/xfce-chromium/src/home), which I use as base-image

### How to use:

#### when downloading from github:
[https://github.com/da-tazzo/pw-awair-uploader](https://github.com/da-tazzo/pw-awair-uploader)  
clone the repo to your Docker host and start the image with
`docker-compose up -d`

#### when pulling from docker hub:
[https://hub.docker.com/repository/docker/datazzo/pw-awair-uploader](https://hub.docker.com/repository/docker/datazzo/pw-awair-uploader)  
type following commands in a shell on your docker host  
`docker pull datazzo/pw-awair-uploader:latest`  
followed by  
`docker run -d -p 5901:5901 -p 6901:6901 datazzo/pw-awair-uploader:latest`  
you may have to prefix the commands with `sudo` if your user has insufficient rights for docker

When using a **graphical frontend (e.g. on Synology DS or similar)**, the image is `datazzo/pw-awair-uploader:latest`  
make sure, you use "*host*"-network (instead of "*bridge*") and that you expose ports 5901 and 6901

#### Starting awair-uploader community tool
When the container is up and running, use your browser (recommandation is Chrome, Firefox or Edge) and navigate to  
`http://<your docker host>:6901/vnc_lite.html`
The password for noVNC is `headless`.  
(if you prefer using the full noVNC client, you could navigate to `http://<your docker host>:6901/vnc.html` instead - there you have e.g. a shared clipboard)

now you should see an ubuntu desktop, where you could open a terminal window from the bottom tool bar (it's the second icon from the left at the time writing this)
By typing `./start-awair-uploader.sh` in the terminal window, you launch the awair-uploader tool.

Please follow instructions from [awair-uploader](https://github.com/Sheherezadhe/awair-uploader) on how to use the tool itself as described at [https://github.com/Sheherezadhe/awair-uploader](https://github.com/Sheherezadhe/awair-uploader)

**BE AWARE: this is a quick solution to get the awair-uploader up and running, without running a laptop/PC 24/7**  
the next step would be to start the awair-uploader with your credentials as parameters, so you don't have manual tasks after restarting teh container

**DON'T MAKE THIS IMAGE ACCESSIBLE FROM THE INTERNET**, because it is not hardened and it may be used as jumphost to access/infiltrate your systems and/or local network or even undisclose your awair/planetwatch credentials.