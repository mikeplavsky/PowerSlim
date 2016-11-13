FROM ubuntu

ARG POWERSHELL_RELEASE=v6.0.0-alpha.12
ARG POWERSHELL_PACKAGE=powershell_6.0.0-alpha.12-1ubuntu1.16.04.1_amd64.deb

# Setup the locale
ENV LANG en_US.UTF-8
ENV LC_ALL $LANG
RUN locale-gen $LANG && update-locale

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libc6 \
        libcurl3 \
        ca-certificates \
        libgcc1 \
        libicu55 \
        libssl1.0.0 \
        libstdc++6 \
        libtinfo5 \
        libunwind8 \
        libuuid1 \
        zlib1g \
        curl \
        git \
    && rm -rf /var/lib/apt/lists/*

RUN curl -SLO https://github.com/PowerShell/PowerShell/releases/download/$POWERSHELL_RELEASE/$POWERSHELL_PACKAGE \
    && dpkg -i $POWERSHELL_PACKAGE \
    && rm $POWERSHELL_PACKAGE

RUN apt-get update 
RUN apt-get install -y default-jre 

RUN mkdir binaries && \
    cd /binaries && \
    curl -o fitnesse-standalone.jar -L \
    "http://fitnesse.org/fitnesse-standalone.jar?responder=releaseDownload&release=20160618" && \
    apt-get update && \
    chmod 777 /binaries/fitnesse-standalone.jar

CMD ["java","-jar","/binaries/fitnesse-standalone.jar", "-v", "-p", "8081"]
