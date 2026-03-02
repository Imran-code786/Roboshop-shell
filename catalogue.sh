component=catalogue
color="\e[36m"
nocolor="\e[0m"



echo -e "${color} Configuraing nodejs repos ${nocolor}"
curl -sL http://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "${color} Install Nodejs${nocolor}"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "${color} Add application user ${nocolor}"
useradd roboshop &>>/tmp/roboshop.log

echo -e "${color} create application directory ${nocolor}"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log

echo -e "${color} Download application content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "${color} Extract application content${nocolor}"
unzip /tmp/${component}.zip &>>/tmp/roboshop.log
cd /app &>>/tmp/roboshop.log

echo -e "${color} Install  Nodejs Dependencies${nocolor}"
npm install &>>/tmp/roboshop.log

echo -e "${color} setup systemd service ${nocolor}"
#vim /etc/systemd/system/${component}.service
cp /root/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>/tmp/roboshop.log

echo -e "${color} start ${component} service ${nocolor}"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable ${component} &>>/tmp/roboshop.log
systemctl start ${component} &>>/tmp/roboshop.log

echo -e "${color} Mongodb reposfile ${nocolor}"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>/tmp/roboshop.log

echo -e "${color} Install mongodb client ${nocolor}"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "${color} load schema ${nocolor}"
mongo --host 172.31.73.151 </app/schema/${component}.js &>>/tmp/roboshop.log



