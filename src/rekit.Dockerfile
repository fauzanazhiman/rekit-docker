# pull official base image
FROM node:10

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

#install phython
RUN printf "deb http://httpredir.debian.org/debian jessie main contrib\ndeb-src http://httpredir.debian.org/debian jessie main contrib\n\ndeb http://httpredir.debian.org/debian jessie-updates main contrib\ndeb-src http://httpredir.debian.org/debian jessie-updates main contrib\n\ndeb http://security.debian.org/ jessie/updates main contrib\ndeb-src http://security.debian.org/ jessie/updates main contrib" > /etc/apt/sources.list.d/backports.list
RUN apt update
RUN apt upgrade
RUN apt install -y make python build-essential

# install rekit
RUN npm install -g rekit 
RUN npm install -g rekit-studio --unsafe-perm=true --allow-root

# install app dependencies
COPY package*.json ./
RUN npm install
RUN npm install react-scripts -g

# add app
COPY . ./

# start app
CMD ["rekit-studio", "-p 3040"]