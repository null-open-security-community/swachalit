# API Authentication

## Authentication and Access Token

JSON Endpoint for authentication:

```
/api/authenticate
```

Input Parameters:

* client_name
* email
* password

Output on-success (HTTP code: 200):

```
{"error":"Success","access_token":"ACCESS-TOKEN"}
```

Output on-failure (HTTP code: 401):

```
{"error":"Authentication failed"}
```

## Example

Successful authentication:

```
$ curl -i --data "email=user@example.com&password=GOODPASSWORD&client_name=CURL" http://127.0.0.1:3000/api/authenticate

HTTP/1.1 200 OK 
X-Frame-Options: DENY
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Content-Type: application/json; charset=utf-8
X-Ua-Compatible: IE=Edge
Etag: "0439a067851769e431e59c54512b207d"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: e4d0fa83af389bbc0f458cac257f478a
X-Runtime: 0.105042
Server: WEBrick/1.3.1 (Ruby/2.1.5/2014-11-13)
Date: Sat, 25 Mar 2017 08:27:50 GMT
Content-Length: 101
Connection: Keep-Alive
Set-Cookie: sessid=0f65b2a1c6ed51f462b769db1a5c6d0a; path=/; HttpOnly

{"error":"Success","access_token":"ACCESS-TOKEN"}
```

Failed authentication:

```
$ curl -i --data "email=abhisek@null.co.in&password=BADPASSWORD&client_name=CURL" http://127.0.0.1:3000/api/authenticate

HTTP/1.1 401 Unauthorized 
X-Frame-Options: DENY
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Content-Type: application/json; charset=utf-8
X-Ua-Compatible: IE=Edge
Cache-Control: no-cache
X-Request-Id: a04fa324b5da4abcd4acbd60af278cfe
X-Runtime: 0.087125
Server: WEBrick/1.3.1 (Ruby/2.1.5/2014-11-13)
Date: Sat, 25 Mar 2017 08:26:31 GMT
Content-Length: 33
Connection: Keep-Alive
Set-Cookie: sessid=d18007cde83082d92e41604c5072b447; path=/; HttpOnly

{"error":"Authentication failed"}
```

## Validate Access Token

Successful validation:

```
$ curl --head -H 'X-Access-Token: ACCESS-TOKEN' http://127.0.0.1:3000/api/is_authenticated

HTTP/1.1 200 OK 
X-Frame-Options: DENY
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Content-Type: application/json; charset=utf-8
X-Ua-Compatible: IE=Edge
Etag: "9dbb3de9521452b96e0fd9b6196a2a8f"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: bf1be7b3f4373648cb63e2806d1e6d16
X-Runtime: 0.045704
Server: WEBrick/1.3.1 (Ruby/2.1.5/2014-11-13)
Date: Sat, 25 Mar 2017 08:42:52 GMT
Content-Length: 0
Connection: Keep-Alive
```

Failed validation:

```
$ curl --head -H 'X-Access-Token: TEST' http://127.0.0.1:3000/api/is_authenticated

HTTP/1.1 401 Unauthorized
X-Frame-Options: DENY
X-Xss-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Content-Type: application/json; charset=utf-8
X-Ua-Compatible: IE=Edge
Cache-Control: no-cache
X-Request-Id: a9a376497b6f1a8e88e847cedcabd30e
X-Runtime: 0.631785
Server: WEBrick/1.3.1 (Ruby/2.1.5/2014-11-13)
Date: Sat, 25 Mar 2017 08:42:12 GMT
Content-Length: 0
Connection: Keep-Alive
```
