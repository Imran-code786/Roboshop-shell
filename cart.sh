echo -e "\e[33mConfiguring Nodejs repos\e[0m"
curl -sl https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install nodejs -y

echo -e "\e[33mInstalling Nginx Server\e[0m"
useradd roboshop

echo -e "\e[33mInstalling Nginx Server\e[0m"

rm -rf /app
mkdir /app 


echo -e "\e[33mInstalling Nginx Server\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip 
cd /app 

echo -e "\e[33mInstalling Nginx Server\e[0m"
unzip /tmp/cart.zip
cd /app 

echo -e "\e[33mInstalling Nginx Server\e[0m"
npm install 

echo -e "\e[33mInstalling Nginx Server\e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[33mInstalling Nginx Server\e[0m"
systemctl daemon-reload
systemctl enable cart 
systemctl start cart

