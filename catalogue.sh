component=catalogue
color="\e[36m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"




echo -e "${color} Configuraing nodejs repos ${nocolor}"
curl -sL http://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

echo -e "${color} Install Nodejs${nocolor}"
yum install nodejs -y &>>${log_file}

echo -e "${color} Add application user ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} create application directory ${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}

echo -e "${color} Download application content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}

echo -e "${color} Extract application content${nocolor}"
unzip /tmp/${component}.zip &>>${log_file}
cd ${app_path} &>>${log_file}

echo -e "${color} Install  Nodejs Dependencies${nocolor}"
npm install &>>${log_file}

echo -e "${color} setup systemd service ${nocolor}"
#vim /etc/systemd/system/${component}.service
cp /root/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>${log_file}

echo -e "${color} start ${component} service ${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component} &>>${log_file}
systemctl start ${component} &>>${log_file}

echo -e "${color} Mongodb reposfile ${nocolor}"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

echo -e "${color} Install mongodb client ${nocolor}"
yum install mongodb-org-shell -y &>>${log_file}

echo -e "${color} load schema ${nocolor}"
mongo --host 172.31.73.151 <${app_path}/schema/${component}.js &>>${log_file}



