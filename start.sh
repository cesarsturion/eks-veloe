#!/bin/sh
export JAVA_ARGS="-Dipv4addr=$(hostname -i) -Dhawtio.realm=activemq -Dhawtio.offline=true -Dhawtio.rolePrincipalClasses=org.apache.activemq.artemis.spi.core.security.jaas.RolePrincipal -Djolokia.policyLocation=file:///home/alpine/veloe-broker/etc/jolokia-access.xml"
echo $JAVA_ARGS
./veloe-broker/bin/artemis run