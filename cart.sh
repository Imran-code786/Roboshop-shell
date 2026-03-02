source common.sh
component=cart


echo -e "${color} configuring Nodejs Repos${nocolor}"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash  &>>${log_file}

echo -e "${color} Install Nodejs${nocolor}"
dnf install nodejs -y   &>>${log_file}

echo -e "${color} add application user ${nocolor}"
useradd roboshop  &>>${log_file}

echo -e "${color} create application directory  ${nocolor}"
rm -rf ${app_path}  &>>${log_file}
mkdir ${app_path}   &>>${log_file}

echo -e "${color}   download application content ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log_file}
cd ${app_path} &>>${log_file}

echo -e "${color} Extract application content ${nocolor}"
unzip /tmp/${component}.zip  &>>${log_file}
cd ${app_path}  &>>${log_file}

echo -e "${color} install nidejs Dependences ${nocolor}"
npm install  &>>${log_file}

echo -e "${color} setup systemd service${nocolor}"
cp /root/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service    &>>${log_file}

echo -e "${color} start ${component} services${nocolor}"
systemctl daemon-reload &>>${log_file}
systemctl enable ${component}   &>>${log_file}
systemctl start ${component}    &>>${log_file}

