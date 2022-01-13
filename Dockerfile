FROM jenkins/jenkins:lts-centos

# Give default username and password to jenkins

ENV JENKINS_USER 19127181

ENV JENKINS_PASS minhkhoi

# skip initial setup

ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# installing required plugins

COPY plugins.txt /usr/share/jenkins/plugins.txt

RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

# copy .mailrc file for sending email

COPY .mailrc $HOME/.mailrc

USER root

# install docker client which will be used to connect host docker daemon

RUN yum install -y sudo mailx yum-utils device-mapper-persistent-data lvm2

RUN yum-config-manager \

  --add-repo   https://download.docker.com/linux/centos/docker-ce.repo

# install docker client which will connect to host docker daemon -- docker-outside-of-docker (dood)

RUN yum install -y docker-ce-cli --nobest

# give jenkins user sudoer permission

RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# add jenkins user to docker group
RUN pip install -r requirements.txt

RUN usermod -aG docker jenkins
