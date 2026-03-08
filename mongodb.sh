#echo -e "${color} Removing old app content${nocolor}"
source common.sh
component=mongodb


echo -e "${color} copy mongodb file${nocolor}"
cp /root/Roboshop-shell/${component}.repo /etc/yum.repos.d/mongod.repo   &>>${log_file}
stat_check $?


echo -e "${color} Installing mongodb${nocolor}"
yum install ${component}-org -y  &>>${log_file}
stat_check $?

echo -e "${color} mongodb listen address ${nocolor}"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf  &>>${log_file}
stat_check $?

echo -e "${color}start mongodb service${nocolor}"
systemctl daemon-reload  &>>${log_file}
systemctl enable mongod  &>>${log_file}
systemctl start mongod  &>>${log_file}
systemctl restart mongod  &>>${log_file}
stat_check $?

###






