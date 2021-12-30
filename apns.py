import json
import jwt
import time

from hyper import HTTPConnection

ALGORITHM = 'ES256'

APNS_KEY_ID = 'AuthKey ID'
APNS_AUTH_KEY = '<AuthKey file>'
TEAM_ID = 'Developers Membership ID Num.'
BUNDLE_ID = 'App ID'

REGISTRATION_ID = 'Device ID'

f = open(APNS_AUTH_KEY)
authKey = f.read()

token = jwt.encode(
    {
        'iss': TEAM_ID,
        'iat': time.time()
    },
    authKey,
    algorithm= ALGORITHM,
    headers={
        'alg': ALGORITHM,
        'kid': APNS_KEY_ID,
    }
)

path = '/3/device/{0}'.format(REGISTRATION_ID)

request_headers = {
    'apns-expiration': '0',
    'apns-priority': '10',
    'apns-topic': BUNDLE_ID,
    'authorization': 'bearer {0}'.format(token)
}

#Developer Push Sever
conn = HTTPConnection('api.development.push.apple.com:443')
#Production Push Server
#conn = HTTPConnection('api.push.apple.com:443')
payload_data = {
    'aps': { 'alert' : 'Hey What's Up' }
}
payload = json.dumps(payload_data)

conn.request(
    'POST',
    path,
    payload,
    headers=request_headers
)
resp = conn.get_response()
