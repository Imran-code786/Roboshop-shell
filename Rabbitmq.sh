
echo -e "\e[33m Configure erlang repos \e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>/tmp/roboshop.log

echo -e "\e[33m Configure Rabbitmq repos\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash  &>>/tmp/roboshop.log

echo -e "\e[33m Install Rabbitmq server\e[0m"
dnf install rabbitmq-server -y   &>>/tmp/roboshop.log

echo -e "\e[33m start rabbitmq server \e[0m"
systemctl enable rabbitmq-server  &>>/tmp/roboshop.log
systemctl start rabbitmq-server   &>>/tmp/roboshop.log

echo -e "\e[33m add rabbitmq application user \e[0m"
rabbitmqctl add_user roboshop roboshop123   &>>/tmp/roboshop.log
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"

