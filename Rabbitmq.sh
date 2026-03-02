source common.sh
component=rabbitmq


echo -e "${color} Configure erlang repos ${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/erlang/script.rpm.sh | bash &>>${log_file}

echo -e "${color} Configure Rabbitmq repos${nocolor}"
curl -s https://packagecloud.io/install/repositories/${component}/${component}-server/script.rpm.sh | bash  &>>${log_file}

echo -e "${color} Install Rabbitmq server${nocolor}"
dnf install ${component}-server -y   &>>${log_file}

echo -e "${color} start rabbitmq server ${nocolor}"
systemctl enable ${component}-server  &>>${log_file}
systemctl start ${component}-server   &>>${log_file}

echo -e "${color} add rabbitmq application user ${nocolor}"
${component}ctl add_user roboshop roboshop123   &>>${log_file}
${component}ctl set_permissions -p / roboshop ".*" ".*" ".*"

