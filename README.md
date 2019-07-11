# Warehouse

In the Divvy Manufacturing floor, we have a bunch of machines that run off of mechanical
wind power. We routinely move our machines around the manufacturing floor as new
machines come out and old ones get retired. We need to get mechanical power from the
output of our windmills to our machines through a complex network of gears. Not only does
the power have to get to the machine, but it also needs to double the RPM of the input
power by the last gear in the system.

This application provides helper functions to be able to determine the necessary gear sizes.

## Dependencies
* Python 3
* Elixir 1.7.3
* Erlang 21.0

Run `mix deps.get` && `pip3 install --user --requirement requirements.txt` to install the necessary python and elixir packages

## Implementations
### Native Elixir
This approach utilizes linear algebra functions and fraction functions written in Native Elixir.
This implementation works well with small datasets (4x faster than the python implementation, although stil uses over 10x the memory; see benchmarking)

### Porting to Python
This approach utilizes python's `numpy` library to handle the linear algebra. It then uses python's
fraction library to resolve the floating decimal point to the closest fraction within a denominator of 10.
This implementation works very well with large datasets (4x faster than the native elixir implementation and over 100x more memory efficient; see benchmarking)

All IO is handled with `IO.gets/1` and `IO.puts/1`. I considered using `Logger` for things like user warnings but it didn't feel like the right use case because
`Logger` is more for application monitoring. 

## Benchmarking
```
Operating System: macOS
CPU Information: Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz
Number of Available Cores: 12
Available memory: 16 GB
Elixir 1.7.4
Erlang 20.1

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 2 s
parallel: 1
inputs: Bigger (20), Medium (10), Small (5)
Estimated total run time: 54 s

Benchmarking native_elixir with input Bigger (20)...
Benchmarking native_elixir with input Medium (10)...
Benchmarking native_elixir with input Small (5)...
Benchmarking python with input Bigger (20)...
Benchmarking python with input Medium (10)...
Benchmarking python with input Small (5)...

##### With input Bigger (20) #####
Name                    ips        average  deviation         median         99th %
python               1.10 K        0.91 ms     ±2.59%        0.91 ms        1.00 ms
native_elixir        0.28 K        3.59 ms     ±7.48%        3.51 ms        4.86 ms

Comparison:
python               1.10 K
native_elixir        0.28 K - 3.96x slower +2.69 ms

Memory usage statistics:

Name             Memory usage
python              0.0226 MB
native_elixir         2.42 MB - 107.09x memory usage +2.40 MB

**All measurements for memory usage were the same**

##### With input Medium (10) #####
Name                    ips        average  deviation         median         99th %
python               2.40 K      416.49 μs     ±8.95%         422 μs         517 μs
native_elixir        2.33 K      428.45 μs     ±5.80%         420 μs         543 μs

Comparison:
python               2.40 K
native_elixir        2.33 K - 1.03x slower +11.96 μs

Memory usage statistics:

Name             Memory usage
python                7.39 KB
native_elixir       299.91 KB - 40.58x memory usage +292.52 KB

**All measurements for memory usage were the same**

##### With input Small (5) #####
Name                    ips        average  deviation         median         99th %
native_elixir       15.03 K       66.55 μs     ±9.33%          65 μs          94 μs
python               3.67 K      272.72 μs    ±11.82%         271 μs      370.28 μs

Comparison:
native_elixir       15.03 K
python               3.67 K - 4.10x slower +206.17 μs

Memory usage statistics:

Name             Memory usage
native_elixir        46.24 KB
python                3.34 KB - 0.07x memory usage -42.90625 KB

**All measurements for memory usage were the same**
```

## Test and Lint
**Format**: `mix format`<br />
**Run tests**: `mix test`<br />
**Lint**: `bin/lint`<br />

## Run
run `mix first_gear_radius`

You will be prompted for the positions of the pegs. Your input will be validated against the following constraints:
* Peg positions are greater than 1 and less than 10,000
* At least 2 pegs are inserted
* The pegs input are in ascending order (if they aren't, you will be warned, the list will be sorted, and the operation will continue)

Input will be collected until either you input a value of `0` or you reach 20 pegs, whichever comes first.

If a gear sequence is found for your peg input, the size of the first gear in the sequenc will be returned as a fractino: [a, b] where the size of the gear is a/b.
If no sequence is found, [-1, -1] will be returned.

## Next things on the horizon
* Compile Python code to C
* Only use fractions where necessary
* Mock IO.gets and test end to end
