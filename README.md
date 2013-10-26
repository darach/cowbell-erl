cowbell-erl
===========

Cowbell - Noddy cowboy throughput benchmark

To build
-------

```bash
$ rebar get-deps compile
$ relx
```

To run
-------

```bash
$ _rel/bin/cowbell foreground
```

Use your favorite http benchmark client, example:

```bash
$ siege -b -c 1 http://localhost:8080/bench/througphut/1k
$ siege -b -c 2 http://localhost:8080/bench/througphut/1k
$ siege -b -c 4 http://localhost:8080/bench/througphut/1k
$ siege -b -c 8 http://localhost:8080/bench/througphut/1k
$ siege -b -c 16 http://localhost:8080/bench/througphut/1k
$ siege -b -c 32 http://localhost:8080/bench/througphut/1k
$ siege -b -c 64 http://localhost:8080/bench/througphut/1k
$ siege -b -c 128 http://localhost:8080/bench/throughput/1k
```

Enjoy!
