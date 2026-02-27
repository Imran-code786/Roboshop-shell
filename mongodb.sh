#echo -e "\e[33m Removing old app content\e[0m"


echo -e "\e[33m copy mongodb file\e[0m"
cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongod.repo   &>>/tmp/roboshop.log


echo -e "\e[33m Installing mongodb\e[0m"
yum install mongodb-org -y  &>>/tmp/roboshop.log

echo -e "\e[33m mongodb listen address \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf  &>>/tmp/roboshop.log

echo -e "\e[33mstart mongodb service\e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log
systemctl enable mongod  &>>/tmp/roboshop.log
systemctl start mongod  &>>/tmp/roboshop.log
systemctl restart mongod  &>>/tmp/roboshop.log






