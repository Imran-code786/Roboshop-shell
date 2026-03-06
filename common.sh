
color="\e[35m"
nocolor="\e[0m"
log_file="/tmp/roboshop.log"
app_path="/app"

stat_check() {
   if [ $1 -eq 0 ]; then
       echo SUCCESS
   else
     echo FAILURE
   fi
}

nodejs(){
   echo -e "${color} Configuraing nodejs repos ${nocolor}"
   curl -sL http://rpm.nodesource.com/setup_lts.x | bash &>>${log_file}

   echo -e "${color} Install Nodejs${nocolor}"
   yum install nodejs -y &>>${log_file}

   app_presetup

   echo -e "${color} Install  Nodejs Dependencies${nocolor}"
   npm install &>>${log_file}

   systemd_setup

}

app_presetup(){

    echo -e "${color} Add application user ${nocolor}"
    id roboshop &>>$log_file
    if [ $? -eq 1 ]; then
      useradd roboshop &>>${log_file}
    fi
    #echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
    stat_check $?

    echo -e "${color} create application directory ${nocolor}"
    rm -rf ${app_path} &>>${log_file}
    mkdir ${app_path} &>>${log_file}
    #echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
     stat_check $?


    echo -e "${color} Download application content${nocolor}"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log_file}
     #echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
    stat_check $?
    cd ${app_path} &>>${log_file}

    echo -e "${color} Extract application content${nocolor}"
    unzip /tmp/${component}.zip &>>${log_file}
    #echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
    stat_check $?
    cd ${app_path} &>>${log_file}
}

systemd_setup(){
     echo -e "${color} setup systemd service ${nocolor}"
     #vim /etc/systemd/system/${component}.service
     cp /root/Roboshop-shell/${component}.service /etc/systemd/system/$component.service  &>>${log_file}
     sed -i -e "s/roboshop_app_password/$roboshop_app_password/" /etc/systemd/system/$component.service

     echo -e "${color} start ${component} service ${nocolor}"
     systemctl daemon-reload &>>${log_file}
     systemctl enable ${component} &>>${log_file}
     systemctl start ${component} &>>${log_file}
     ##echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
     stat_check $?

}

mongod_schema_setup(){

    echo -e "${color} Mongodb reposfile ${nocolor}"
    cp /root/Roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log_file}

    echo -e "${color} Install mongodb client ${nocolor}"
    yum install mongodb-org-shell -y &>>${log_file}

    echo -e "${color} load schema ${nocolor}"
    mongo --host 172.31.73.151 <${app_path}/schema/${component}.js &>>${log_file}
}

maven(){

    echo -e "${color} Install maven ${nocolor}"
    dnf install maven -y &>>${log_file}

    echo -e "${color} depemdency ${nocolor}"
    mvn clean package  &>>${log_file}
    mv target/${component}-1.0.jar ${component}.jar &>>${log_file}
    mysql_schema_setup
    systemd_setup
}


mysql_schema_setup(){

   echo -e "${color} star mysql ${nocolor}"
   dnf install mysql -y  &>>${log_file}

   echo -e "${color} cheksk${nocolor}"
   mysql -h 172.31.8.118 -uroot -pRoboShop@1 < ${app_path}/schema/${component}.sql  &>>${log_file}
}

python(){

    echo -e "${color}mInstall Python${nocolor}"
    dnf install python36 gcc python3-devel -y    &>>${log_file}
    ##echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
    stat_check $?

    app_presetup

    echo -e "${color}mInstall application Dependencies${nocolor}"
    cd ${app_path}    &>>${log_file}
    pip3.6 install -r requirements.txt    &>>${log_file}
    #echo $?
#    if [ $? -eq 0 ]; then
#       echo SUCCESS
#    else
#      echo FAILURE
#    fi
    stat_check $?

    systemd_setup

}