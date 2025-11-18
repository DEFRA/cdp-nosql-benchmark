#!/bin/bash
set -e

if [ -n "$MONGO_CA_BASE64" ]; then
    echo "$MONGO_CA_BASE64" | base64 -d > /opt/mongo-ca.pem
    keytool -importcert -trustcacerts \
        -keystore $JAVA_HOME/lib/security/cacerts \
        -storepass changeit \
        -noprompt \
        -alias mongo-ca \
        -file /opt/mongo-ca.pem
fi

exec "$@"
