#!/bin/bash

# 部署配置
project_path=${1}
server_directory=${2#*:}
server_host=${2%:*}

echo '> 开始打包'
cd "$project_path" || exit
npm run build || exit

echo '> 开始上传'
ssh -Tq "$server_host" <<EOF
mkdir -p $server_directory
rm -rf $server_directory/*
exit
EOF

if [ -d "build" ]; then
  scp -O -r "$(pwd)/build/*" "$server_host":"$server_directory" || exit
elif [ -d "dist" ]; then
  scp -O -r "$(pwd)/dist/*" "$server_host":"$server_directory" || exit
fi

echo -e "\033[32m> 部署完成\033[0m"
