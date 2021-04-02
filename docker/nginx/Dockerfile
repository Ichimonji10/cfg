FROM gcc
COPY ["compile-public", "."]
RUN ["make"]

FROM nginx:alpine
LABEL maintainer="jerebear@protonmail.com"
COPY ["copy-public/etc-nginx", "/etc/nginx/"]
COPY ["copy-public/etc-nginx-conf.d", "/etc/nginx/conf.d/"]
COPY ["copy-public/usr-share-nginx", "/usr/share/nginx/"]
COPY --from=0 ["*.chained.crt", "/etc/nginx/ssl/"]
