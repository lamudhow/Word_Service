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

- [Dockerfile](/Dockerfile)
- [lib/Words.pm](/lib/Words.pm)
- [lib/Word_Service.pm](/lib/Word_Service.pm)
- [config.yml (end)](/config.yml)
- [cpanfile](/cpanfile)
- [t/Words.t](/t/Words.t)
- [t/002_index_route.t](/t/002_index_route.t)

## Thanks

Thanks for the opportunity to show you my work. Please contact
[myself](mailto:michael.brader@gmail.com) or Randi if you'd like to
know anything more.
