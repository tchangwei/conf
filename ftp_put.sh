#!/bin/bash
ftp -n<<!
open 192.168.1.171
user guest 123456
binary
cd /home/data
lcd /home/databackup
prompt
#单个文件
put a.sh a.sh
#多个文件
mput *
close
bye
!
