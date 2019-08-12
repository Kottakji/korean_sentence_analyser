FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y g++ openjdk-8-jdk python3 python3-dev python3-pip curl
RUN apt-get install -y wget build-essential autotools-dev automake libmecab2 libmecab-dev git
RUN pip3 install konlpy bottle gunicorn
RUN apt-get install -y python-dev
RUN apt-get install -y python-pip

RUN curl -s https://raw.githubusercontent.com/konlpy/konlpy/master/scripts/mecab.sh | bash

RUN pip3 install Flask

EXPOSE 5000

ENV FLASK_APP=sever.py

COPY . /app
WORKDIR /app

ENTRYPOINT ["python3"]
CMD ["app.py"]

