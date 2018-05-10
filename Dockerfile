FROM arm32v6/golang:1.9-alpine
MAINTAINER Denys Vitali <denys@denv.it>
COPY ./qemu-arm-static /usr/bin/qemu-arm-static 
RUN apk add --no-cache wget tar bash
RUN wget -O /tmp/prometheus.tar.gz https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-armv6.tar.gz
RUN mkdir /tmp/prometheus
RUN tar -xvf /tmp/prometheus.tar.gz -C /tmp/prometheus 
RUN mkdir /etc/prometheus
RUN ls -la /tmp/prometheus/prometheus-2.2.1.linux-armv6
RUN cp /tmp/prometheus/*/prometheus /bin/
RUN cp /tmp/prometheus/*/promtool /bin/
RUN cp /tmp/prometheus/*/prometheus.yml /etc/prometheus
RUN cp -r /tmp/prometheus/*/console_libraries /etc/prometheus
RUN cp -r /tmp/prometheus/*/consoles /etc/prometheus
EXPOSE 9090 
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/etc/prometheus/console_libraries", \
             "-web.console.templates=/etc/prometheus/consoles" ]
