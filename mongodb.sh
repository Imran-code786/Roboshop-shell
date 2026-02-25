#echo -e "\e[33m Removing old app content\e[0m"


echo -e "\e[33m copy mongodb file\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo   &>>/tmp/roboshop.log


echo -e "e\[33m Installing mongodb\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log

echo -e "e\[33m mongodb listen address \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[33mstart mongodb service\e[0m"
systemctl enable mongodb
systemctl restart mongodb






