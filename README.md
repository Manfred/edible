# Edible

Edible is a basic builder for EDIFACT data. Support for a parser is on its way.

```ruby
Edible.build(
  decimal_notation: ',',
  interchange: 'UNOA',
  version: 2
) do
  segment('UNH', 1, 'PAORES', [93, 1, 'IA'])
end
```

Produces this:

```
UNA:+,? '
UNB+UNOA:2'
UNH+1+PAORES+93:1:IA'
```
