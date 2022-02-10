#!/bin/bash

# 部署配置
local_path="{local_path}"
remote_path="/usr/share/nginx/html/{path}"
remote_user_host="{remote_user_host}"

echo '> 开始打包'
cd $local_path || exit
npm run craco-build || exit

echo '> 开始上传'
ssh -Tq  $remote_user_host << "EOF"
remote_path="/usr/share/nginx/html/{path}"
rm -rf $remote_path/*
exit
EOF

scp -r $local_path/build/* $remote_user_host:$remote_path || exit

echo -e "\033[32m> 部署完成\033[0m"
