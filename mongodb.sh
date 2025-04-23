echo -e "\e[33mInstalling Nginx Server\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling mongodb Server\e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdate  mongodb Listen Address\e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

echo -e "\e[33mInstalling mongodb Service\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log


