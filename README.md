# Port Scanner in Ruby

Simple port scanner in ruby.

## Getting Started

To run the program you need to provide the host and de subcommand ```quick``` or ```full```.

```
ruby port_scanner.rb 127.0.0.1 quick
```

### Subcommands
* ```quick```: will test the most common ports 80, 443, 21, 22...
* ```full```: will test all port from 1 to 65535.
