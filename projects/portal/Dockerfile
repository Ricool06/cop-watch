FROM circleci/node:lts-browsers as builder
WORKDIR /usr/src/app
USER root
COPY . .
RUN npm install && npm run lint && npm run test:ci && npm run e2e && npm run build:prod

FROM nginx:stable-alpine
COPY nginx/nginx.conf /etc/nginx/nginx.conf
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /usr/src/app/dist .
