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

# Set the environment variable again in the production stage
ARG MO_GIT_COMMIT_AUTHOR
ENV MO_GIT_COMMIT_AUTHOR=${MO_GIT_COMMIT_AUTHOR}

EXPOSE 8080
USER 101
CMD /bin/sh -c 'echo "Git Commit Author: ${MO_GIT_COMMIT_AUTHOR}" && nginx -g "daemon off;"'
