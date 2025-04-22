echo -e "\e[33mInstalling Nginx Server\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling mongodb Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

#modify the config file

echo -e "\e[33mInstalling mongodb Service\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log


