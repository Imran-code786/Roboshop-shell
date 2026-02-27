
echo -e "\e[33mInstall Python\e[0m"
dnf install python36 gcc python3-devel -y   &>>/tmp/roboshop.log

echo -e "\e[33madd application user\e[0m"
useradd roboshop   &>>/tmp/roboshop.log

echo -e "\e[33mcreate application directorye[0m"
rm -rf /app   &>>/tmp/roboshop.log
mkdir /app    &>>/tmp/roboshop.log


echo -e "\e[33m Download application content\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip  &>>/tmp/roboshop.log
cd /app  &>>/tmp/roboshop.log

echo -e "\e[33mExtract application content\e[0m"
unzip /tmp/payment.zip  &>>/tmp/roboshop.log

echo -e "\e[33mInstall application Dependencies\e[0m"
cd /app   &>>/tmp/roboshop.log
pip3.6 install -r requirements.txt   &>>/tmp/roboshop.log

echo -e "\e[33msetup systemd\e[0m"
cp /root/Roboshop-shell/payment.service /etc/systemd/system/payment.service   &>>/tmp/roboshop.log


echo -e "\e[33m start payment service\e[0m"
systemctl daemon-reload   &>>/tmp/roboshop.log


systemctl enable payment   &>>/tmp/roboshop.log
systemctl start payment    &>>/tmp/roboshop.log