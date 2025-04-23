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
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip 
cd /app 

echo -e "\e[33mInstalling Nginx Server\e[0m"
unzip /tmp/user.zip
cd /app 

echo -e "\e[33mInstalling Nginx Server\e[0m"
npm install 

echo -e "\e[33mInstalling Nginx Server\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[33mInstalling Nginx Server\e[0m"
systemctl daemon-reload
systemctl enable user 
systemctl start user

echo -e "\e[33mInstalling Nginx Server\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install mongodb-org-shell -y


echo -e "\e[33mInstalling Nginx Server\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js