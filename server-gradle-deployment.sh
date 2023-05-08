#!/bin/bash

# 部署配置（替换变量值）
project_path=${1}
server_directory=${2#*:}
server_host=${2%:*}
server_port=${3}

echo '> 开始打包'
cd "$project_path" || exit
./gradlew bootJar

echo '> 开始上传'
ssh -Tq "$server_host" "mkdir -p $server_directory"
scp "$project_path"/build/libs/*.jar "$server_host":"$server_directory"

echo '> 开始启动'
ssh -Tq "$server_host" <<EOF
cd $server_directory
pid="\$(lsof -i:$server_port | sed -n "2,1p" | awk '{print \$2}')"
test -n "\$pid" && kill -9 "\$pid"
nohup java -jar *.jar > nohup.out 2>&1 &
exit
EOF

echo -e "\033[32m> 部署完成\033[0m"
