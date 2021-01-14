FROM gcc
COPY ["ssl-certs", "."]
RUN ["make"]

FROM nginx:alpine
LABEL maintainer="jerebear@protonmail.com"
COPY ["-usr-share-nginx-", "/usr/share/nginx/"]
COPY ["-etc-nginx-conf.d-", "/etc/nginx/conf.d/"]
COPY --from=0 ["*.chained.crt", "/etc/nginx/ssl/"]
