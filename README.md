A simple Perl (Dancer2) web app to find words matching supplied
strings of letters. A docker container is defined.

## Installation instructions

These instructions are similar to those in the specification. The
docker build has not been pushed to hub.docker.com but can be accessed
from GitHub

```
$ git clone https://github.com/lamudhow/Word_Service.git
...
$ docker build -t submission .
...
$ docker run -d -p 8080:80 submission
...
$ curl -i http://localhost:8080/ping
HTTP/1.0 200 OK
...
$ curl http://localhost:8080/wordfinder/dgo
[ "do", "dog", "go", "god" ]
```

## Code guide

There is quite a bit of boilerplate code in here from Dancer2. Most of
the code I have written is in the following files:

- [Dockerfile](/lamudhow/Word_Service/blob/main/Dockerfile)
- [lib/Words.pm](/lamudhow/Word_Service/blob/main/lib/Words.pm)
- [lib/Word_Service.pm](/lamudhow/Word_Service/blob/main/lib/Word_Service.pm)
- [config.yml (end)](/lamudhow/Word_Service/blob/main/config.yml)
- [cpanfile](/lamudhow/Word_Service/blob/main/cpanfile)
- [t/Words.t](/lamudhow/Word_Service/blob/main/t/Words.t)
- [t/t/002_index_route.t.t](/lamudhow/Word_Service/blob/main/t/t/002_index_route.t.t)

## Thanks

Thanks for the opportunity to show you my work. Please contact
[myself]{mailto:michael.brader@gmail.com) or Randi if you'd like to
know anything more.
