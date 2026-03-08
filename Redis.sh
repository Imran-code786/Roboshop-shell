source common.sh
component=redis



echo -e "${color} Install Redis Server ${nocolor}"
#yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y  &>>${log_file}
#stat_check $?

dnf module disable ${component} -y  &>>${log_file}
echo -e "${color} Enable Redis server ${nocolor}"
yum module enable ${component}:6 -y  &>>${log_file}
stat_check $?

echo -e "${color} Install Redis ${nocolor}"
yum install ${component}  &>>${log_file}

mkdir -p /etc/${component}  &>>${log_file}
cp /etc/${component}.conf /etc/${component}/${component}.conf  &>>${log_file}
stat_check $?

echo -e "${color}Update Redis listen address ${nocolor}"
#sed -i 's/127.0.0.1/0.0.0.0'  /etc/${component}.conf  /etc/${component}/${component}.conf
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/${component}.conf /etc/${component}/${component}.conf  &>>${log_file}
sed -i 's/^bind .*/bind 0.0.0.0/' /etc/${component}.conf  &>>${log_file}
stat_check $?

echo -e "${color} Start redis server ${nocolor}"
systemctl enable ${component}  &>>${log_file}
systemctl restart ${component}  &>>${log_file}
stat_check $?
