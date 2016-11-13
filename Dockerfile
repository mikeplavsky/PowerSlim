FROM microsoft/powershell 

RUN apt-get update 
RUN apt-get install -y default-jre 

RUN mkdir binaries && \
    cd /binaries && \
    curl -o fitnesse-standalone.jar -L \
    "http://fitnesse.org/fitnesse-standalone.jar?responder=releaseDownload&release=20160618" && \
    apt-get update && \
    chmod 777 /binaries/fitnesse-standalone.jar

CMD ["java","-jar","/binaries/fitnesse-standalone.jar", "-v", "-p", "8081"]
