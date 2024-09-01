FROM ruby:2.6.2-slim

RUN echo "deb http://archive.debian.org/debian/ stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update -y

RUN apt-get update -y --allow-insecure-repositories && \
    apt-get install -y build-essential libpq-dev nodejs libsqlite3-dev default-libmysqlclient-dev libxml2-dev

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY . /app

EXPOSE 8800

CMD ["bash", "./script/run_docker_app.sh"]
