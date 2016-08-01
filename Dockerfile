FROM florendg/iplus_sonar

VOLUME /qualityprofile

ADD start_with_profile.sh /opt/sonarqube/start_with_profile.sh
ADD qualityprofile/iplus_qa-96544.xml /opt/sonarqube/qualityprofile/iplus_qa-96544.xml

RUN apt-get update
RUN apt-get -y install curl

RUN chmod -R 777 /opt/sonarqube/start_with_profile.sh

ENTRYPOINT ["/opt/sonarqube/start_with_profile.sh"]
