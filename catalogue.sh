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
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip 
cd /app 

echo -e "\e[33mInstalling Nginx Server\e[0m"
unzip /tmp/catalogue.zip
cd /app 

echo -e "\e[33mInstalling Nginx Server\e[0m"
npm install 

echo -e "\e[33mInstalling Nginx Server\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[33mInstalling Nginx Server\e[0m"
systemctl daemon-reload
systemctl enable catalogue 
systemctl start catalogue

echo -e "\e[33mInstalling Nginx Server\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[33mInstalling Nginx Server\e[0m"
yum install mongodb-org-shell -y


echo -e "\e[33mInstalling Nginx Server\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js