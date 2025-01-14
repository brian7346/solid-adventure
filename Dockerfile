FROM python:3.4

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi

RUN pip install Flask==0.10.1 uWSGI==2.0.18 requests==2.5.1 redis==2.10.3
WORKDIR /app

COPY app /app
COPY cmd.sh /

RUN chmod +x /cmd.sh
# Добавляем права на чтение и выполнение для всех пользователей
RUN chmod 755 /app && \
    chmod 644 /app/identidock.py && \
    chown -R uwsgi:uwsgi /app

EXPOSE 9090 9191
USER uwsgi

CMD ["/cmd.sh"]