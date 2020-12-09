# 基于node11
FROM node:11

# 设置环境变量
ENV PROJECT_ENV production
ENV NODE_ENV production

# 安装nginx
RUN apt-get update && apt-get install -y nginx

# 把 package.json package-lock.json 复制到/app目录下
# 为了npm install可以缓存
COPY package*.json /app/

# 切换到app目录
WORKDIR /app

# 安装依赖
RUN npm install --registry=https://registry.npm.taobao.org

# 把所有源代码拷贝到/app
COPY . /app

# 打包构建
RUN npm run build

# 拷贝配置文件到nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# 启动nginx，关闭守护式运行，否则容器启动后会立刻关闭
CMD ["nginx", "-g", "daemon off;"]

作者：深红
链接：https://juejin.cn/post/6844903956305412109
来源：掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。