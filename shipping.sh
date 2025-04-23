echo -e "\e[33mInstall maven \e[0m"
yum install maven -y

echo -e "\e[33mApplication useer\e[0m"
useradd roboshop

echo -e "\e[33m Create application directory \e[0m"
rm -rf /app
mkdir /app 

echo -e "\e[33m Download application content\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip 

echo -e "\e[33m Extract  application content\e[0m"
unzip /tmp/shipping.zip


echo -e "\e[33m Download maven dependemcies \e[0m"
mvn clean package 
mv target/shipping-1.0.jar shipping.jar 

echo -e "\e[33m Install mysql client \e[0m"
yum install mysql -y 

echo -e "\e[33m load schema \e[0m"
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql 


echo -e "\e[33m start shipping service  \e[0m"
systemctl daemon-reload

systemctl enable shipping 
systemctl start shipping

