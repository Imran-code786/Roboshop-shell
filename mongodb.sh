
echo -e "\e[33mcopy mongodb file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo   &>>/tmp/roboshop.log


echo -e "e\[33m Installing mongodb\2[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log

echo -e "e\[33m mongodb listen address \2[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongodb.conf

echo -e "\e[33mstart mongodb service\e[0m"
systemctl enable mongodb
systemctl restart mongodb






