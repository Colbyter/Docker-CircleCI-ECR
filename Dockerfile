FROM python:2.7.15

# Setting App environment
RUN mkdir -p /home/circleci_docker/
RUN mkdir -p /home/circleci_docker/logs/
WORKDIR /home/circleci_docker/
COPY . /home/circleci_docker/


RUN apt-get update -y
RUN apt-get -qq install -y python python-pip supervisor curl 
#RUN apt-get install -y nginx
RUN apt-get -qq upgrade -y

RUN pip install -U pip
RUN pip install -r requirements.txt

# Setting Gunicorn with Supervisor
RUN mkdir -p /var/log/supervisor/
RUN rm -v /etc/supervisor/supervisord.conf
COPY /shared/supervisord.conf /etc/supervisor/
COPY /shared/gunicorn.conf /etc/supervisor/conf.d/


ENV APP_IP 0.0.0.0
ENV APP_PORT 10060

EXPOSE 10060 80

HEALTHCHECK --interval=15s --timeout=15s --retries=5\
  CMD curl -f -I -4 http://0.0.0.0:10060/liveness

CMD ["/usr/bin/supervisord"]