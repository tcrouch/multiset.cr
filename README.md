# multiset

A multiset (bag) implementation in Crystal.


## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  multiset:
    github: tcrouch/multiset.cr
```


## Usage


```crystal
require "multiset"
```

### Example
```
ms1 = Multiset{1, 1}
ms1 << 2                          => Multiset{1, 1, 2}
ms1.merge [3, 4]                  => Multiset{1, 1, 2, 3, 4}
ms2 = Multiset.new [2, 3, 4]
ms2.subset?(ms1)                  => true
ms1 & ms2                         => Multiset{2, 3, 4}
```

## Development

`crystal spec`

## Contributing

1. Fork it ( https://github.com/tcrouch/multiset.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[tcrouch]](https://github.com/tcrouch) Tom Crouch - creator, maintainer
