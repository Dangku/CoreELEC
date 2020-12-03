#docker pull coreelec/coreelec-builder:latest
docker run -v /home/dangku:/home/docker -h coreelec -it coreelec/coreelec-builder:latest

# PROJECT=Amlogic-ng ARCH=arm make image
