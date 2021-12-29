#Extrac Cert and Key from .crt file downloaded from apple developers Account
#openssl pkcs12 -in apnss.p12 -out apnskey.key -nodes -nocerts 
#openssl pkcs12 -in apnss.p12 -out apnskey.crt -nokeys

#SandBox
CERTIFICATE_FILE_NAME="Apple Push Sandbox Cert"
CERTIFICATE_KEY_FILE_NAME="Apple Push Sandox Cert Key"
TOPIC="App ID"
DEVICE_TOKEN="<device token>"
APNS_HOST_NAME=api.sandbox.push.apple.com
curl -v --header "apns-topic: ${TOPIC}" \
--header "apns-push-type: alert" \
--cert "${CERTIFICATE_FILE_NAME}"\
--cert-type PEM \
--key "${CERTIFICATE_KEY_FILE_NAME}" \
--key-type PEM --data '{"aps":{"alert":"test"}}' \
--http2  https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}

#Production
CERTIFICATE_FILE_NAME="Apple Push Prod. Cert"
CERTIFICATE_KEY_FILE_NAME="Apple Push Prod. Cert Key"
TOPIC="App ID"
DEVICE_TOKEN="<device token>"
APNS_HOST_NAME=api.push.apple.com
curl -v --header "apns-topic: ${TOPIC}" \
--header "apns-push-type: alert" \
--cert "${CERTIFICATE_FILE_NAME}" \
--cert-type PEM \
--key "${CERTIFICATE_KEY_FILE_NAME}" \
--key-type PEM --data '{"aps":{"alert":"test"}}' \
--http2  https://${APNS_HOST_NAME}/3/device/${DEVICE_TOKEN}
