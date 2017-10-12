#!/bin/bash
cwd=$(dirname $0)
cd  $cwd

source /etc/profile

log_path=$cwd/checker_$(date +%s)

function rt_check(){
    rt=$?
    check_item=$1
    if [ $rt -ne 0 ]
    then
        ok_flag=1
        echo ERROR "$check_item"
        echo ERROR "$check_item" >> $log_path
    fi
}


# os version
uname -r 2>&1 | grep '2.6.32-.*.el6.x86_64' > /dev/null 2>&1
rt_check 'os version'

# java
java -version 2>&1 | grep 'java version "1.8' > /dev/null 2>&1
rt_check "jdk 1.8"

# python
python -V 2>&1 | grep 'Python 2.' > /dev/null 2>&1
rt_check "python"

# pip
pip -V 2>&1 | grep 'pip' > /dev/null 2>&1
rt_check "pip"

# hadoop client
hadoop version 2>&1 | grep 'Hadoop 2.6.' > /dev/null 2>&1
rt_check 'hadoop client'

# python module
python_modules=("elasticsearch==2.3.0" "Jinja2" "ConcurrentLogHandler" "MySQL-python" "pika" "PyYAML" "setproctitle" "tornado" "urllib3")

for module in ${python_modules[@]}
do 
    pip freeze 2>&1 | grep $module > /dev/null 2>&1;
    rt_check "$module"
done

# domain
hosts=("xxxx.master.xxx" "xxx.master.xxx" "xxx.master.axx")
for domain in ${hosts[@]}
do
    ping -c 3 $domain 2>&1 | grep '64 bytes from' > /dev/null 2>&1
    rt_check "$domain"
done

# 1xx.xx.xx.xx    xxx.xx
ping -c 3 mysqlm.xxx.xxxx 2>&1 | grep "x.x.x.xx"  > /dev/null 2>&1
rt_check "xxxxxxx"

# send mail
curl -v "http://mail.xxxxxx" 2>&1 | grep "Connection #0 to host mail.xxxxx" > /dev/null 2>&1
rt_check "mail.xxxxx"

# pig
pig -version 2>&1 | grep "Apache Pig version 0.16.0"  > /dev/null 2>&1
rt_check "pig 1.6.0"

# mvn
mvn -version 2>&1 | grep "Apache Maven"  > /dev/null 2>&1
rt_check "mvn"

# ftp
rpm -qa | grep ftp 2>&1 | grep "ftp" > /dev/null 2>&1
rt_check "ftp"

# git
git --version 2>&1 | grep "git" > /dev/null 2>&1
rt_check "git"

# max user processes
ulimit -a | grep "max user processes" | grep "unlimited" > /dev/null 2>&1
rt_check "ulimit max user processes"
