FROM node:14.5-alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# Beanstalk looks for exposed ports
EXPOSE 80
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html