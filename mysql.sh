source common.sh
component=mysql


echo -e "${color}mDisable mysql default version file${nocolor}"
yum module disable ${component} -y  &>>${log_file}

echo -e "${color}m setup systemd service ${nocolor}"
cp /root/Roboshop-shell/${component}.repo /etc/yum.repos.d/${component}.repo  &>>${log_file}

echo -e "${color}mInstall mysql community server${nocolor}"
yum install ${component}-community-server -y  &>>${log_file}

echo -e "${color}mstart mysql service${nocolor}"
systemctl enable ${component}d  &>>${log_file}
systemctl start ${component}d   &>>${log_file}

echo -e "${color}metup mysql password${nocolor}"
${component}_secure_installation --set-root-pass RoboShop@1   &>>${log_file}


${component} -uroot -pRoboShop@1