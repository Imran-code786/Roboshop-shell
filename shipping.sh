
echo -e "\e[33m Install maven \e[0m"
dnf install maven -y

echo -e "\e[33m  add application user \e[0m"
useradd roboshop

echo -e "\e[33m create application directory  \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app &>>/tmp/roboshop.log


echo -e "\e[33m Download application content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app  &>>/tmp/roboshop.log

echo -e "\e[33m Extract application content \e[0m"
unzip /tmp/shipping.zip  &>>/tmp/roboshop.log

cd /app  &>>/tmp/roboshop.log


echo -e "\e[33m depemdency \e[0m"
mvn clean package  &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log


echo -e "\e[33 setuo systemctl m \e[0m"
cp /root/Roboshop-shell/shipping.service /etc/systemd/system/shipping.service  &>>/tmp/roboshop.log


echo -e "\e[33m  load schema \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log

systemctl enable shipping  &>>/tmp/roboshop.log
systemctl start shipping  &>>/tmp/roboshop.log


echo -e "\e[33m star mysql \e[0m"
dnf install mysql -y  &>>/tmp/roboshop.log

echo -e "\e[33m cheksk\e[0m"
mysql -h 172.31.8.118 -uroot -pRoboShop@1 < /app/schema/shipping.sql  &>>/tmp/roboshop.log

echo -e "\e[33m  restart \e[0m"
systemctl restart shipping  &>>/tmp/roboshop.log