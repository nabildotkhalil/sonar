#!/bin/bash
#
#start Sonar
nohup /opt/sonarqube-4.5/bin/linux-x86-64/sonar.sh console & 

function curlAdmin {
    curl -v -u admin:admin $@
}

BASE_URL=http://127.0.0.1:9000

function isUp {
    curl -s -u admin:admin -f "$BASE_URL/api/server"
}

# Wait for server to be up
PING=`isUp`
while [ -z "$PING" ]
do
    sleep 5
    PING=`isUp`
done

#upload profile xml file to sonar
curlAdmin -F "backup=@/opt/sonarqube/qualityprofile/iplus_qa-96544.xml" -X POST http://localhost:9000/api/profiles/restore

#set as default profile
curlAdmin -X POST "http://localhost:9000/api/profiles/set_as_default?language=java&name=infoplus_QA"

wait
