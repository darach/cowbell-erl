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

Use your favorite http benchmark client, example for HTTP GET:

```bash
$ siege -b -c 1 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 2 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 4 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 8 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 16 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 32 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 64 -r 100 http://localhost:8080/bench/throughput/1k
$ siege -b -c 128 -r 100 http://localhost:8080/bench/througphut/1k
```

Generate some data files:

```bash
dd if=/dev/urandom of=1m.dat bs=10485760 count=1
dd if=/dev/urandom of=100k.dat bs=102400 count=1
dd if=/dev/urandom of=10k.dat bs=10240 count=1
dd if=/dev/urandom of=1k.dat bs=1024 count=1
````

And you can also exercise HTTP POST:

```bash
siege -b -c 1 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 2 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 4 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 8 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 16 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 32 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 64 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
siege -b -c 128 -r 100 http://localhost:6467/bench/throughput/1k < 1k.dat
```

Enjoy!
