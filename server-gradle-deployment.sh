#!/bin/bash

# 部署配置（替换变量值）
local_path="{local_path}"
remote_path="{remote_path}"
remote_user_host="{remote_user_host}"
app_port="{app_port}"

echo '> 开始打包'
cd $local_path || exit
./gradlew bootJar || exit

echo '> 开始上传'
ssh -Tq  $remote_user_host "mkdir -p $remote_path"
scp $local_path/build/libs/*.jar $remote_user_host:$remote_path

echo '> 开始启动'
ssh -Tq $remote_user_host <<EOF
cd $remote_path
pid="\$(lsof -i:$app_port | sed -n "2,1p" | awk '{print \$2}')"
test -n "\$pid" && kill -9 "\$pid"
nohup java -jar *.jar > nohup.out 2>&1 &
exit
EOF

echo -e "\033[32m> 部署完成\033[0m"
