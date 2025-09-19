# ---- Build stage ----
FROM node:18-alpine AS build
WORKDIR /app

COPY ./app .

RUN yarn install
RUN yarn build


# ---- Serve stage ----
FROM nginx:1.27-alpine
COPY --from=build app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]