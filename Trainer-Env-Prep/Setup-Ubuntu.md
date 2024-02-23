sudo apt -y update
sudo apt -y install openssl tree zip unzip
sudo groupadd docker
for ((i=1;i<=50;i++)); do
	export username="u$i"
	sudo useradd -m -p "p2" $username;sudo usermod -aG sudo $username;sudo usermod -aG docker $username;echo $username:p | sudo /usr/sbin/chpasswd;sudo chown -R  $username:root /home/$username
done
cat ~/.bashrc
echo 'export PS1="\e[0;31m\e[50m\u@\h\n\w \e[m\n$ "'   >> ~/.bashrc
cat ~/.bashrc
#########################################
sudo apt -y update
sudo apt-get -y install r-base
sudo apt -y update
sudo apt-get  -y install gdebi-core
wget -c https://s3.amazonaws.com/rstudio-ide-build/server/jammy/amd64/rstudio-server-2022.07.2-576-amd64.deb
sudo gdebi rstudio-server-2022.07.2-576-amd64.deb

free -h
curl http://localhost:8787
