FROM python:3.12.0a7-alpine3.17

ADD ./src /opt/src
WORKDIR /opt/src
ADD docker-entrypoint.sh /

RUN chmod +x /docker-entrypoint.sh
RUN pip3 install -r requirements.txt && pip3 install gunicorn   

EXPOSE 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
