
echo -e "\e[33m Install Redis Server \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[33m Enable Redis server \e[0m"
yum module enable redis:6 -y

echo -e "\e[33m Install Redis \e[0m"
yum install redis

echo -e "\e[33mUpdate Redis listen address \e[0m"
#sed -i 's/127.0.0.1/0.0.0.0'  /etc/redis.conf  /etc/redis/redis.conf
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf /etc/redis/redis.conf

echo -e "\e[33m Start redis server \e[0m"
systemctl enable redis
systemctl start redis
