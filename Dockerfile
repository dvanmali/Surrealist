FROM node:20-alpine as build

WORKDIR /build
COPY package.json .
RUN npm install

# Creates /dist
COPY . .
RUN npm run build

##############
# PRODUCTION #
##############
FROM nginx:stable-alpine-slim as prod

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /build/dist /usr/share/nginx/html

EXPOSE 8080