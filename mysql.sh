source common.sh
component=mysql


echo -e "${color}Disable mysql default version file${nocolor}"
yum module disable ${component} -y  &>>${log_file}
stat_check $?

echo -e "${color} setup systemd service ${nocolor}"
cp /root/Roboshop-shell/${component}.repo /etc/yum.repos.d/${component}.repo  &>>${log_file}
stat_check $?

echo -e "${color}Install mysql community server${nocolor}"
yum install ${component}-community-server -y  &>>${log_file}
stat_check $?

echo -e "${color}start mysql service${nocolor}"
systemctl enable ${component}d  &>>${log_file}
systemctl start ${component}d   &>>${log_file}
stat_check $?

echo -e "${color}setup mysql password${nocolor}"
${component}_secure_installation --set-root-pass RoboShop@1   &>>${log_file}
stat_check $?

${component} -uroot -pRoboShop@1
stat_check $?