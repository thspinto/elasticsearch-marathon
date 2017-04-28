#!/bin/bash

if [[ -z "$ES_NETWORK_PUBLISH_HOST" && -n "$HOSTNAME_COMMAND" ]]; then
    export ES_NETWORK_PUBLISH_HOST=$(eval $HOSTNAME_COMMAND)
fi
for VAR in `env`
do
  if [[ $VAR =~ ^ES_ ]]; then
    es_name=`echo "$VAR" | sed -r "s/ES_(.*)=.*/\1/g" | tr '[:upper:]' '[:lower:]' | tr _ .`
    env_var=`echo "$VAR" | sed -r "s/(.*)=.*/\1/g"`
    if egrep -q "(^|^#)$es_name: " ./config/elasticsearch.yml; then
        sed -r -i "s@(^|^#)($es_name): (.*)@\2: ${!env_var}@g" ./config/elasticsearch.yml #note that no config values may contain an '@' char
    else
        echo "$es_name: ${!env_var}" >> ./config/elasticsearch.yml
    fi
  fi
done

cat ./config/elasticsearch.yml
exec ./cluster
