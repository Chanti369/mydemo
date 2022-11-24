FROM couchbase/centos7-systemd as build
RUN yum install -y git
RUN yum install -y java-1.8*
WORKDIR /opt
RUN git clone https://github.com/Chanti369/build.git
ADD https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz /opt
RUN tar -xvf *.tar.gz
RUN mv apache-maven-3.8.6 maven
WORKDIR /etc/profile.d/
RUN touch maven.sh
RUN echo "export M2_HOME=/opt/maven" >>maven.sh
RUN echo "export PATH=${M2_HOME}/bin:${PATH}" >>maven.sh
RUN chmod 777 maven.sh
RUN source /etc/profile.d/maven.sh
WORKDIR /usr/bin
RUN ln -s /opt/maven/bin/mvn mvn
WORKDIR /opt/build/
RUN mvn clean install


FROM couchbase/centos7-systemd
RUN yum install -y java-1.8*
WORKDIR /opt
ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.78/bin/apache-tomcat-8.5.78.tar.gz /opt
RUN tar -xvf apache-tomcat-8.5.78.tar.gz
RUN mv apache-tomcat-8.5.78 tomcat
COPY --from=build /opt/build/context.xml /opt/tomcat/webapps/manager/META-INF/
COPY --from=build /opt/build/tomcat-users.xml /opt/tomcat/conf/
RUN touch /etc/systemd/system/tomcat.service
RUN chmod 777 /etc/systemd/system/tomcat.service
COPY --from=build /opt/build/tomcat.service /etc/systemd/system/
COPY --from=build /opt/build/target/*.war /opt/tomcat/webapps/
RUN systemctl enable tomcat.service
CMD ["systemctl","start","tomacat.service"]