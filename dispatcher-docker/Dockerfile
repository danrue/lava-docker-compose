FROM lavasoftware/amd64-lava-dispatcher:2018.11

# Install ser2net 3.5 from sid
# max-connections needs ser2net version >=3.2
# stretch comes with 2.1.
RUN rm -rf /var/lib/apt/lists/* && \
    echo "deb http://deb.debian.org/debian/ sid main" >> /etc/apt/sources.list.d/sid.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install ser2net && \
    rm -f /etc/apt/sources.list.d/sid.list && \
    apt-get update

COPY entrypoint.sh /root/
ENTRYPOINT ["/root/entrypoint.sh"]
