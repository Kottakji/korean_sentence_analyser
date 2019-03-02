FROM docker.elastic.co/elasticsearch/elasticsearch-oss:6.1.1

RUN bin/elasticsearch-plugin install https://github.com/open-korean-text/elasticsearch-analysis-openkoreantext/releases/download/6.1.1/elasticsearch-analysis-openkoreantext-6.1.1.2-plugin.zip

CMD ["eswrapper"]
