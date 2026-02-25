
echo -e "\e[33m Configuraing nodejs repos \e[0m"
curl -sL http://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m Install Nodejs\e[0m"
yum install nodejs -y

echo -e "\e[33m Add application user \e[0m"
useradd roboshop

echo -e "\e[33m create application directory \e[0m"
rm -rf /app
mkdir /app

echo -e "\e[33m Download application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app

echo -e "\e[33m Extract application content\e[0m"
unzip /tmp/catalogue.zip
cd /app

echo -e "\e[33m Install  Nodejs Dependencies\e[0m"
npm install

echo -e "\e[33m setup systemd service \e[0m"
#vim /etc/systemd/system/catalogue.service
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[33m start catalogue service \e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[33m Mongodb reposfile \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongod.repo

echo -e "\e[33m Install mongodb client \e[0m"
dnf install mongodb-org-shell -y

echo -e "\e[33m load schema \e[0m"
mongo --host mongodb-dev.imrankhandevops72.online </app/schema/catalogue.js


