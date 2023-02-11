FROM docker.io/redhat/ubi9 AS base

RUN dnf -y update && dnf -y install unzip wget java-1.8.0-openjdk
WORKDIR /app
RUN wget https://mediafilez.forgecdn.net/files/3861/870/Crucial2-1.4.4-server.zip
RUN unzip Crucial2-1.4.4-server.zip
RUN rm -f setup_server.sh
COPY setup_server_headless.sh /app/setup_server.sh
RUN /bin/bash setup_server.sh
RUN rm -f forge-installer.jar.log setup_server.*

FROM docker.io/redhat/ubi9 AS final
RUN dnf -y update && dnf -y install https://download-ib01.fedoraproject.org/pub/epel/9/Everything/x86_64/Packages/e/epel-release-9-4.el9.noarch.rpm
RUN /usr/bin/crb enable
RUN dnf -y install neofetch java-1.8.0-openjdk
RUN mkdir /minecraft

RUN dnf clean all
COPY --from=base /app/ /app/
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
COPY neo.conf /etc/neo.conf
WORKDIR /minecraft/
CMD ["/app/entrypoint.sh"]