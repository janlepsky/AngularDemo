# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
ARG MO_GIT_COMMIT_AUTHOR
ENV MO_GIT_COMMIT_AUTHOR=${MO_GIT_COMMIT_AUTHOR}

# production stage
FROM nginxinc/nginx-unprivileged:stable-alpine as production-stage
COPY --from=build-stage /app/dist/angular-app /usr/share/nginx/html

# Copy the start script into the image
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
USER 101
CMD ["/start.sh"]

