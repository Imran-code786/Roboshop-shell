
echo -e "\e[33m Configuraing nodejs repos \e[0m"
curl -sL http://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33m Install Nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33m Add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33m create application directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "\e[33m Download application content\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33m Extract application content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "\e[33m Install  Nodejs Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33m setup systemd service \e[0m"
#vim /etc/systemd/system/catalogue.service
cp catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33m start catalogue service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[33m Mongodb reposfile \e[0m"
cp mongodb.repo /etc/yum.repos.d/mongod.repo &>>/tmp/roboshop.log

echo -e "\e[33m Install mongodb client \e[0m"
dnf install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33m load schema \e[0m"
mongo --host 172.31.73.151 </app/schema/catalogue.js &>>/tmp/roboshop.log


