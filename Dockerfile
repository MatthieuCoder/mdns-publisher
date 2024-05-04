FROM debian

RUN apt update && apt install -y avahi-utils dbus

WORKDIR /app
COPY start.sh start.sh
RUN chmod +x start.sh
RUN mkdir -p /var/run/dbus && mkdir -p /run/dbus

ENTRYPOINT ["bash", "-c", "cat /conf/configuration | bash /app/start.sh"]
