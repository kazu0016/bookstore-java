# 1. Base image oficial do WildFly
FROM quay.io/wildfly/wildfly:26.0.0.Final

USER root

# 2. Usuário admin para o Painel Web (Porta 9990)
RUN /opt/jboss/wildfly/bin/add-user.sh admin admin123 --silent

# 3. Baixar o driver JDBC do MySQL
RUN curl -L -o /tmp/mysql-connector-java.jar https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.28/mysql-connector-java-8.0.28.jar

# 4. Configurar o WildFly (Instalar Driver e Datasource MySQL)
RUN /opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 & \
    sleep 15 && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --commands="\
    module add --name=com.mysql --resources=/tmp/mysql-connector-java.jar --dependencies=javax.api\,javax.transaction.api, \
    /subsystem=datasources/jdbc-driver=mysql:add(driver-name=mysql,driver-module-name=com.mysql,driver-class-name=com.mysql.cj.jdbc.Driver), \
    data-source add --name=MySQLDS --jndi-name=java:jboss/datasources/MySQLDS --driver-name=mysql --connection-url=jdbc:mysql://bookstore-db:3306/bookstore_db --user-name=user_kazu --password=password_kazu --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.mysql.MySQLValidConnectionChecker --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.mysql.MySQLExceptionSorter" && \
    /opt/jboss/wildfly/bin/jboss-cli.sh --connect --command=:shutdown && \
    rm -rf /opt/jboss/wildfly/standalone/configuration/standalone_xml_history/*

# Garante permissões de diretórios
RUN mkdir -p /opt/jboss/wildfly/standalone/log /opt/jboss/wildfly/standalone/data /opt/jboss/wildfly/standalone/tmp && \
    chown -R jboss:root /opt/jboss/wildfly/standalone && \
    chmod -R g+rwX /opt/jboss/wildfly/standalone

# 5. Copiar o WAR (O arquivo que você gerou no Maven)
COPY bookstore.war /opt/jboss/wildfly/standalone/deployments/
RUN chown jboss:jboss /opt/jboss/wildfly/standalone/deployments/bookstore.war

USER jboss
EXPOSE 8080 9990

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]