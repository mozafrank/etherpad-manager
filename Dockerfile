FROM debian:sid

RUN apt update && apt install -y curl jq && apt update

WORKDIR /opt

COPY etherpad-manager.sh /opt/etherpad-manager.sh

CMD /opt/etherpad-manager.sh
