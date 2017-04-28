FROM elasticsearch:2.4.4

COPY cluster .
COPY start_elasticsearch.sh .
RUN chmod +x start_elasticsearch.sh

EXPOSE 9200 9300
ENTRYPOINT ["./start_elasticsearch.sh"]
CMD ["elasticsearch"]
