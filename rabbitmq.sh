echo -e "\e[33m Configure Erlang repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash

echo -e "\e[33m Configure Rabbitmq repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash

echo -e "\e[33m Install Rabbitmq\e[0m"
yum install rabbitmq-server -y 

echo -e "\e[33m start rabbitmq\e[0m"
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server 

echo -e "\e[33m Add rabbitmq user\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

