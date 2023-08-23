* Settings *
Library    RequestsLibrary

* Variables *
${API_URL}    https://api.twitter.com/2/tweets
${CONSUMER_KEY}    Qg16Q9qLOiCcs8UuTlwqwhgxk
${ACCESS_TOKEN}    4557504739-uQyqw5oJJQwyl9T06pWeNv1RF5mU5fNBRSEBvSZ
${SIGNATURE_METHOD}    HMAC-SHA1
${TIMESTAMP}    1692770856
${NONCE}    59ikreUnGHn
${OAUTH_VERSION}    1.0
${OAUTH_SIGNATURE}    2WTJ0KA%2F7Zda1gULxoLPzDaOvo8%3D

* Test Cases *
Post Tweet
    ${headers}    Create Dictionary    Content-Type=application/json    Authorization=OAuth oauth_consumer_key="${CONSUMER_KEY}",oauth_token="${ACCESS_TOKEN}",oauth_signature_method="${SIGNATURE_METHOD}",oauth_timestamp="${TIMESTAMP}",oauth_nonce="${NONCE}",oauth_version="${OAUTH_VERSION}",oauth_signature="${OAUTH_SIGNATURE}"
    ${payload}    Create Dictionary    text=Hello World!
   # ${response}    Post Request    ${API_URL}    json=${payload}    headers=${headers}
  #  Log    Response Status Code: ${response.status_code}
   # Log    Response Content: ${response.text}
   # Should Be Equal As Strings    ${response.status_code}    200