# HTTP Request dump utility

Dumps the request into the response body, so that the roundtrip can be expected from the client.
The utility is useful when implementing authentication via API GW or oauth2_proxy, to check the request is passed correctly with all necessary header.

# Usage

User docker image from `npenkov/http-req-dump`

```bash
docker pull npenkov/http-req-dump
```

```bash
docker run --name=dump-req -p 8080:8080 npenkov/http-req-dump
```

Run request:

```bash
curl -i http://localhost:8080/this/is/some/request/path \
    -X PUT -H 'Authorization: Bearer MySecretToken' \
    -H'Content-Type: application/json' -d'{"field1": "value1", "field2": "value2"}'
```

Results in:

```
HTTP/1.1 200 OK
Date: Wed, 13 May 2020 08:39:47 GMT
Content-Length: 232
Content-Type: text/plain; charset=utf-8

PUT /this/is/some/request/path HTTP/1.1
Host: localhost:8080
Accept: */*
Authorization: Bearer MySecretToken
Content-Length: 40
Content-Type: application/json
User-Agent: curl/7.68.0

{"field1": "value1", "field2": "value2"}
```

## License

Copyright (c) 2020 Nick Penkov. All rights reserved. Use of this source code is governed by a MIT-style license that can be found in the [LICENSE](LICENSE) file.