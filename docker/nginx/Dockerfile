FROM gcc
COPY ["compile", "."]
RUN ["make"]

FROM nginx:alpine
LABEL maintainer="jerebear@protonmail.com"
COPY ["copy/etc-nginx", "/etc/nginx/"]
COPY ["copy/etc-nginx-conf.d", "/etc/nginx/conf.d/"]
COPY ["copy/usr-share-nginx", "/usr/share/nginx/"]
COPY --from=0 ["*.chained.crt", "/etc/nginx/ssl/"]
