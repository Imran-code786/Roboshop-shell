
echo -e "\e[33m configure nodejs repo  \e[0m"
curl -sL htts://rpm nodesource.com/setup-lts.x | bash  &>>/tmp/roboshop.log

echo -e "\e[33m  Install nodejs  \e[0m"
dnf install nodejs -y  &>>/tmp/roboshop.log

echo -e "\e[33m Add application user  \e[0m"
useradd roboshop  &>>/tmp/roboshop.log

echo -e "\e[33m create application directory  \e[0m"
rm -rf /app  &>>/tmp/roboshop.log
mkdir /app  &>>/tmp/roboshop.log

echo -e "\e[33m download application content  \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Extract application content  \e[0m"
cd /app  &>>/tmp/roboshop.log
unzip /tmp/user.zip  &>>/tmp/roboshop.log


cd /app  &>>/tmp/roboshop.log

echo -e "\e[33m Install nodejs dependencies \e[0m"
npm install  &>>/tmp/roboshop.log

echo -e "\e[33m  setup system  \e[0m"
cp /root/Roboshop-shell/user.service /etc/systemd/system/user.service  &>>/tmp/roboshop.log

echo -e "\e[33m start user  \e[0m"
systemctl daemon-reload  &>>/tmp/roboshop.log

systemctl enable user  &>>/tmp/roboshop.log
systemctl restart user  &>>/tmp/roboshop.log
