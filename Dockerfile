FROM  centos

LABEL Vickey Sandhu <vijay62020@gmail.com>

ARG MAVEN_VERSION=3.8.1

ARG USER_HOME_DIR="/root"

ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN GRADLE_VERSION=7.0

ARG GRADLE_BASE_URL=https://services.gradle.org/distributions

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.282.b08-2.el8_3.x86_64/

ENV GRADLE_HOME=/usr/bin/gradle

ENV PATH $PATH:$GRADLE_HOME/bin

RUN yum install -y git java-1.8.0-openjdk-devel  unzip && mkdir -p /usr/share/maven /usr/share/maven/ref \
    && mkdir -p /usr/share/gradle /usr/share/gradle/ref \
    && curl -fsSL -o /tmp/gradle.zip https://services.gradle.org/distributions/gradle-7.0-bin.zip  \
 && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
 && unzip -d /usr/share/gradle /tmp/gradle.zip \
 && ln -s  /usr/share/gradle/gradle-7.0/bin/gradle  /usr/bin/gradle  \
 && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
 && rm -f /tmp/apache-maven.tar.gz \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn  && export JAVA_HOME && export GRADLE_HOME

COPY target/*.jar  *.jar
ENTRYPOINT [ "java", "-jar" , "*.jar" ]
