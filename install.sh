  cat << EOF > ./startup.sh
sudo apt update
# openssh-server
sudo /etc/init.d/ssh start
EOF


echo "admin:admin:Y" > CREATEUSERS.TXT
echo "ubuntu:ubuntu:N" >> CREATEUSERS.TXT
docker run -dit  \
          --name=ubuntu20.04 \
		  --net mynet \
           --privileged=true \
           -p 3389:3389 \
           -p 2222:22 \
           -e TZ="Europe/Rome" \
           -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
           -v ${PWD}/CREATEUSERS.TXT:/root/createusers.txt \
           -v ${PWD}/startup.sh:/root/startup.sh \
           -v ${PWD}/data:/data \
           --shm-size="1gb" `#optional` \
           valyc/docker-ubuntu-xrdp-mate-work:6
		   
		   
docker run -d \
  --name=remmina \
  --net mynet \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/Rome \
  -p 3000:3000 \
  lscr.io/linuxserver/remmina
