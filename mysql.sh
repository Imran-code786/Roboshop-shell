
echo -e "\e[33m Disable Mysql Default version\e[0m"
yum module disable mysql -y 

echo -e "\e[33mInstal Mysql community server\e[0m"
yum install mysql-community-server -y

echo -e "\e[33m Start mysql service\e[0m"
systemctl enable mysqld
systemctl start mysqld  

echo -e "\e[33m setup mysql\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1


