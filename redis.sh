
echo -e "\e[33mInstalling Redis repo\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[33m Enable redis 6 version\e[0m"
yum module enable redis:6 -y &>>/tmp/roboshop.log

echo -e "\e[33m Install Redis\e[0m"
yum install redis -y  &>>/tmp/roboshop.log

echo -e "\e[33m update redis listn address\e[0m" 
sed -i 's/127.0.0.1/0.0.0.0/'  /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[33m start redis service\e[0m"
systemctl enable redis &>>/tmp/roboshop.log

systemctl start redis &>>/tmp/roboshop.log