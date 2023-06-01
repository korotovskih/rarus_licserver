FROM ubuntu:latest as prepear

ARG LICSERVER_URI="https://rarus.ru/downloads/2553/licserver_2.0.19.457_amd64.deb"

RUN apt-get update && \ 
    apt-get install -y wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /licserver && \
    wget -q --continue -O /licserver/amd64_deb.tgz $LICSERVER_URI && \
    dpkg-deb -xv /licserver/amd64_deb.tgz /licserver

FROM ubuntu:23.10

COPY --from=prepear /licserver/usr/bin/LicServer /usr/bin/LicServer

EXPOSE 15200 15201
ENTRYPOINT [ "/usr/bin/LicServer" ]
CMD [ "-r" ]

