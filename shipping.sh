source common.sh
component=shipping


echo -e "${color} Install maven ${nocolor}"
dnf install maven -y &>>${log_file}

echo -e "${color}  add application user ${nocolor}"
useradd roboshop &>>${log_file}

echo -e "${color} create application directory  ${nocolor}"
rm -rf ${app_path} &>>${log_file}
mkdir ${app_path} &>>${log_file}


echo -e "${color} Download application content ${nocolor}"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
cd ${app_path}  &>>${log_file}

echo -e "${color} Extract application content ${nocolor}"
unzip /tmp/${component}.zip  &>>${log_file}

cd ${app_path}  &>>${log_file}


echo -e "${color} depemdency ${nocolor}"
mvn clean package  &>>${log_file}
mv target/${component}-1.0.jar ${component}.jar &>>${log_file}


echo -e "${color} setup systemctl  ${nocolor}"
cp /root/Roboshop-shell/${component}.service /etc/systemd/system/${component}.service  &>>${log_file}


echo -e "${color}  load schema ${nocolor}"
systemctl daemon-reload  &>>${log_file}

systemctl enable ${component}  &>>${log_file}
systemctl start ${component}  &>>${log_file}


echo -e "${color} star mysql ${nocolor}"
dnf install mysql -y  &>>${log_file}

echo -e "${color} cheksk${nocolor}"
mysql -h 172.31.8.118 -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql  &>>${log_file}

echo -e "${color}  restart ${nocolor}"
systemctl restart ${component}  &>>${log_file}