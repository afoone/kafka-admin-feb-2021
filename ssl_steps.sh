keytool -genkeypair -keyalg RSA -keysize 2048 -keystore server.ca.p12 -storetype PKCS12 -storepass server-ca-password -keypass server-ca-password -alias ca -dname "CN=BrokerCA" -ext bc=ca:true -validity 365

keytool -export -file server.ca.crt -keystore server.ca.p12 -storetype PKCS12 -storepass server-ca-password -alias ca -rfc

keytool -genkey -keyalg RSA -keysize 2048 -keystore server.ks.p12 -storetype PKCS12 -storepass server-ks-password -keypass server-ks-password -alias server -dname "CN=Kafka, O=Iprocuratio, C=ES" -ext bc=ca:true -validity 365
keytool -certreq -file server.csr -keystore server.ks.p12 -storetype PKCS12 -storepass server-ks-password -keypass server-ks-password -alias server
keytool -gencert -infile server.csr -outfile server.crt -keystore server.ca.p12 -storetype PKCS12 -storepass server-ca-password -alias ca -ext SAN=DNS:localhost -validity 365
cat server.crt server.ca.crt > serverchain.crt
keytool -importcert -file serverchain.crt -keystore server.ks.p12 -storepass server-ks-password -keypass server-ks-password -alias server -storetype PKCS12 -noprompt

keytool -import -file server.ca.crt -keystore server.ts.p12 -storepass server-ts-password -alias server -storetype PKCS12 -noprompt

keytool -import -file server.ca.crt -keystore client.ts.p12 -storepass client-ts-password -alias ca -storetype PKCS12 -noprompt

