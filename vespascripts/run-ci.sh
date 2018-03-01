#!/bin/bash

export VESPA_APP=/vespaapp
export PATH=/opt/vespa/bin:${PATH}

echo "copying changed configuration files (services and hosts) to support distributed vespa"
cp /vespascripts/services.xml ${VESPA_APP}/basic-search/src/main/application
cp /vespascripts/hosts.xml ${VESPA_APP}/basic-search/src/main/application

for i in 1 2 3 4 5 6 7 8 9 10; do 
    date
    echo "waiting 15 seconds for vespa to come up - attempt: ${i}"
    sleep 15
    echo "vespa-deploy prepare ${VESPA_APP}/basic-search/src/main/application/ && break"
    vespa-deploy prepare ${VESPA_APP}/basic-search/src/main/application/ && break
done

vespa-deploy activate 
printf 'Checking Vespa Application Status on port 19071\n'
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:19071/ApplicationStatus)" != "200" ]]; do 
    printf '.'
    sleep 3; 
done

printf 'Checking Vespa Application Status on port 8080 on stateless0 (can take a few seconds)\n'
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' http://stateless0:8080/ApplicationStatus)" != "200" ]]; do 
    printf '.'
    sleep 3; 
done

curl -s -X POST --data-binary @${VESPA_APP}/basic-search/music-data-1.json http://localhost:8080/document/v1/music/music/docid/1 | python -m json.tool
curl -s -X POST --data-binary @${VESPA_APP}/basic-search/music-data-2.json http://localhost:8080/document/v1/music/music/docid/2 | python -m json.tool
curl -s http://localhost:8080/search/?query=bad | python -m json.tool


