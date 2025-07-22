FROM maven:3.9.6-eclipse-temurin-21

RUN apt-get update && \
    apt-get install -y inotify-tools curl && \
    rm -rf /var/lib/apt/lists/*

COPY watcher.sh /watcher.sh
RUN chmod +x /watcher.sh

CMD ["/watcher.sh"]
