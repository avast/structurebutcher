# Structure Butcher

This library is for playing with configs (in YAML, Hocon, JSON,
JavaProperties). It provides two scripts:

- amputator.rb - reads a part of the config structure given filename and path
  to a key.

- implantator.rb - writes a given data structure into a file on a place
  specified by a path to a key

Example:

    $ cat body.yaml
    ---
    one:
      two:
        three:
          hash:
            one: 1
            two: 2
            three: 3

    $ bin/amputator.rb body.yaml one.two.three.hash part.json

    $ cat part.json
    {"one":1,"two":2,"three":3}

    $ bin/implantator.rb body.yaml one.two part.json

    $ cat body.yaml
    ---
    one:
      two:
        one: 1
        two: 2
        three: 3

For examples on how to use the library, see `tests`.
