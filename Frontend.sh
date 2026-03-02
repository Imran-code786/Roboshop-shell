source common.sh
component=frontend


echo -e "${color} Installing Nginx service${nocolor}"
yum install nginx -y  &>>${log_file}

echo -e "${color} Removing old app content${nocolor}"
rm -rf /usr/share/nginx/html/*  &>>${log_file}

echo -e "${color} Downloading ${component} content${nocolor}"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip  &>>${log_file}

echo -e "${color} Extract ${component} conten${nocolor}"
cd /usr/share/nginx/html &>>${log_file}
unzip /tmp/${component}.zip  &>>${log_file}



#vim /etc/nginx/default.d/roboshop.conf
echo -e "${color}Update ${component} config${nocolor}"
cp /root/Roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>${log_file}

echo -e "${color}staring nginx server${nocolor}"
systemctl enable nginx &>>${log_file}
systemctl restart nginx &>>${log_file}


