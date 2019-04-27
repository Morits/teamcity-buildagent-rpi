FROM debian:latest
WORKDIR /
COPY . .
RUN apt update; \
 apt install -y curl gcc g++ make unzip apt-transport-https ca-certificates gnupg2 git mercurial pkg-config; \
 curl -sL https://deb.nodesource.com/setup_12.x | bash -; \
 apt install -y nodejs; \
 curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -; \
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list; \
 curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -; \
 echo "deb [arch=armhf] https://download.docker.com/linux/debian stretch stable" | tee /etc/apt/sources.list.d/docker.list; \
 apt update && apt install yarn docker-ce-cli; \
 apt install -y openjdk-8-jre-headless; \
 mkdir -p /data/teamcity_agent; \
 unzip ./buildAgent.zip -d /data/teamcity_agent; \
 rm buildAgent.zip;

#RUN /data/teamcity_agent/bin/agent.sh run; exit 0
#RUN cp /data/teamcity_agent/conf/buildAgent.dist.properties /data/teamcity_agent/conf/buildAgent.properties; \
#  sed -i 's|serverUrl=http://localhost:8111/|serverUrl=http://172.20.0.12:8111/|g' /data/teamcity_agent/conf/buildAgent.properties

CMD ["/data/teamcity_agent/bin/agent.sh", "run"]
