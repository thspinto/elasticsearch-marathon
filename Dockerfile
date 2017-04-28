FROM elasticsearch:2.4.4

COPY cluster /

EXPOSE 9200 9300
ENTRYPOINT ["/cluster"]
CMD ["start_elasticsearch.sh"]
