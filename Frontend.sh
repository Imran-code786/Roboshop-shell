echo -e "\e[33m  Istalling Nginx service\e[0m"
yum install nginx -y  &>>/tmp/roboshop.log

echo -e "\e[33m Removing old app content\e[0m"
rm -rf /usr/share/nginx/html/*  &>>/tmp/roboshop.log

echo -e "\e[33m Downloading Frontend content\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>/tmp/roboshop.log

echo -e "\e[33m Extract Frontend conten\e[0m"
cd /usr/share/nginx/html &>>/tmp/roboshop.log
unzip /tmp/frontend.zip  &>>/tmp/roboshop.log



#vim /etc/nginx/default.d/roboshop.conf
echo -e "\e[33mUpdate Frontend config\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf &>>/tmp/roboshop.log

echo -e "\e[33mstaring nginx server\e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log


