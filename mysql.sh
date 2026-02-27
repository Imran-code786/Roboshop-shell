
echo -e "\e[33mDisable mysql default version file\e[0m"
yum module disable mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m setup systemd service \e[0m"
cp /root/Roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo  &>>/tmp/roboshop.log

echo -e "\e[33mInstall mysql community server\e[0m"
yum install mysql-community-server -y  &>>/tmp/roboshop.log

echo -e "\e[33mstart mysql service\e[0m"
systemctl enable mysqld  &>>/tmp/roboshop.log
systemctl start mysqld   &>>/tmp/roboshop.log

echo -e "\e[33metup mysql password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1   &>>/tmp/roboshop.log


mysql -uroot -pRoboShop@1