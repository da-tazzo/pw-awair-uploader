# pw-awair-uploader
docker image build for awair-uploader for Planetwatch

just clone this repo to your docker host and start the image with
`docker-compose up -d --build`

when the container is running, use your browser and navigate to 
`http://<your docker host>:6901`

the pw for noVNC is "headless"

many thanks to [accetto](https://github.com/accetto) for his [ubuntu-xfce-chromium image](https://github.com/accetto/headless-coding-g3/tree/master/docker/xfce-chromium/src/home), which I use here as base-image
