#!/bin/bash

# 部署配置（替换变量值）
local_path="{local_path}"
remote_path="{remote_path}"
remote_user_host="{remote_user_host}"

echo '> 开始打包'
cd $local_path || exit
./gradlew bootJar

echo '> 开始上传'
scp $local_path/build/libs/*.jar $remote_user_host:$remote_path

echo '> 开始启动'
ssh -Tq  remote_user_host << "EOF"

# 配置启动端口和路径
app_port="{app_port}"
remote_path="{remote_path}"

cd $remote_path
pid=$(lsof -i:$app_port | sed -n "2,1p" | awk '{print $2}')
test -n "$pid" && kill -9 "$pid"
nohup java -jar *.jar >nohup.out 2>&1 &
exit
EOF

echo -e "\033[32m> 部署完成\033[0m"
