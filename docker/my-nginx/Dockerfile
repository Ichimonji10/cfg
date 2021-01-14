FROM nginx:alpine
LABEL maintainer="jerebear@protonmail.com"
COPY ["sites/", "/usr/share/nginx/"]
COPY ["configs/", "/etc/nginx/conf.d/"]
COPY ["ssl/*.chained.crt", "/etc/nginx/ssl/"]
