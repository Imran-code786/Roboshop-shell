source common.sh
component=user


echo -e "${color} configure nodejs repo  ${nocolor}"
curl -sL htts://rpm nodesource.com/setup-lts.x | bash  &>>${log_file}

echo -e "${color}  Install nodejs  ${nocolor}"
dnf install nodejs -y  &>>${log_file}

echo -e "${color} Add application user  ${nocolor}"
${component}add roboshop  &>>${log_file}

echo -e "${color} create application directory  ${nocolor}"
rm -rf ${app_path}  &>>${log_file}
mkdir ${app_path}  &>>${log_file}

echo -e "${color} download application content  ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log_file}

echo -e "${color} Extract application content  ${nocolor}"
cd ${app_path}  &>>${log_file}
unzip /tmp/${component}.zip  &>>${log_file}


cd ${app_path}  &>>${log_file}

echo -e "${color} Install nodejs dependencies ${nocolor}"
npm install  &>>${log_file}

echo -e "${color}  setup system  ${nocolor}"
cp /root/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>${log_file}

echo -e "${color} start user  ${nocolor}"
systemctl daemon-reload  &>>${log_file}

systemctl enable ${component}  &>>${log_file}
systemctl restart ${component}  &>>${log_file}
