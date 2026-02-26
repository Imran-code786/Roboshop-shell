

curl -sL htts://rpm nodesource.com/setup-lts.x | bash


dnf install nodejs -y


useradd roboshop


rm -rf /app
mkdir /app

curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip

cd /app
unzip /tmp/user.zip


cd /app


npm install


cp /root/Roboshop-shell/user.service /etc/systemd/system/user.service


systemctl daemon-reload

systemctl enable user
systemctl restart user
