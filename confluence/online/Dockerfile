# source image come from https://hub.docker.com/r/atlassian/confluence-server/
FROM atlassian/confluence-server

# copy mysql connect plugin
COPY mysql-connector-java-5.1.47.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/

# copy crack file
COPY atlassian-extras-decoder-v2-3.4.1.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/

# change file owner
RUN chown daemon.daemon /opt/atlassian/confluence/confluence/WEB-INF/lib/mysql-connector-java-5.1.47.jar /opt/atlassian/confluence/confluence/WEB-INF/lib/atlassian-extras-decoder-v2-3.4.1.jar \

# add execute for mysql connect plugin
&& chmod +x /opt/atlassian/confluence/confluence/WEB-INF/lib/mysql-connector-java-5.1.47.jar \

# change timezone
&& echo 'http://mirrors.ustc.edu.cn/alpine/v3.5/main' > /etc/apk/repositories \
&& echo 'http://mirrors.ustc.edu.cn/alpine/v3.5/community' >>/etc/apk/repositories \
&& apk update && apk add tzdata \
&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
&& echo "Asia/Taipei" > /etc/timezone
