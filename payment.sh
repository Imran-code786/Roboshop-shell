source common.sh
component=payment


echo -e "${color}mInstall Python${nocolor}"
dnf install python36 gcc python3-devel -y    &>>${log_file}

echo -e "${color}madd application user${nocolor}"
useradd roboshop    &>>${log_file}

echo -e "${color}mcreate application directorye[0m"
rm -rf ${app_path}    &>>${log_file}
mkdir ${app_path}     &>>${log_file}


echo -e "${color}m Download application content${nocolor}"
curl -L -o /tmp/${${component}}.zip https://roboshop-artifacts.s3.amazonaws.com/${${component}}.zip   &>>${log_file}
cd ${app_path}   &>>${log_file}

echo -e "${color}mExtract application content${nocolor}"
unzip /tmp/${${component}}.zip   &>>${log_file}

echo -e "${color}mInstall application Dependencies${nocolor}"
cd ${app_path}    &>>${log_file}
pip3.6 install -r requirements.txt    &>>${log_file}

echo -e "${color}msetup systemd${nocolor}"
cp /root/Roboshop-shell/${${component}}.service /etc/systemd/system/${${component}}.service    &>>${log_file}


echo -e "${color}m start payment service${nocolor}"
systemctl daemon-reload    &>>${log_file}


systemctl enable ${${component}}    &>>${log_file}
systemctl start ${${component}}     &>>${log_file}