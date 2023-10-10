# 常用的部署脚本

## 前端与后端部署发布脚本

使用方式

- Github

```shell
zsh -c "$(curl -skL https://raw.githubusercontent.com/xiaohaoo/server-deployment/main/server-gradle-deployment.sh)" -s {project_path} {server_host:server_directory} {server_port}
```

```shell
zsh -c "$(curl -skL https://raw.githubusercontent.com/xiaohaoo/server-deployment/main/web-npm-deployment.sh)" -s {project_path} {server_host:server_directory}
```

- Gitee

```shell
zsh -c "$(curl -skL https://gitee.com/xiaohaoo/server-deployment/raw/main/server-gradle-deployment.sh)" -s {project_path} {server_host:server_directory} {server_port}
```

```shell
zsh -c "$(curl -skL https://gitee.com/xiaohaoo/server-deployment/raw/main/web-npm-deployment.sh)" -s {project_path} {server_host:server_directory}
```

### 后端发布

后端使用Gradle构建Java项目，发布脚本：[脚本程序](server-gradle-deployment.sh)。

### 前端发布

前端使用Npm构建Web项目，发布脚本：[脚本程序](web-npm-deployment.sh)。

## Nginx相关配置

### HTTPS配置

需要将[脚本程序](nginx/https.conf)放入Nginx的配置目录(/etc/nginx/conf.d/)下，自动加载配置。

### 端口转发配置

需要将[脚本程序](nginx/location.conf)放入Nginx的配置目录(/etc/nginx/default.d/)下，自动加载配置。
