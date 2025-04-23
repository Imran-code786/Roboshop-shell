echo -e "\e[33mInstalling Nginx Server\e[0m"
yun install nginx  -y &>>/tmp/roboshop.log

echo -e "\e[34m Removing old App content\e[0m"
rm -rf /user/share/nginx/html/* &>>/tmp/roboshop.log

echo -e "\35m Downloading Froentend content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip  &>>/tmp/roboshop.log

echo -e "\35m Extract Frontend content \e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>/tmp/roboshop.log

cho -e "\35m Update  Frontend configuration \e[0m"
cp /home/centos/roboshop-shell/roboshop.conf /etc/nginx/default.d/robroboshop.conf

echo -e "\35m starting Nginx server \e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log

