# haversine

![Crystal CI](https://github.com/geocrystal/haversine/workflows/Crystal%20CI/badge.svg?branch=master)
[![GitHub release](https://img.shields.io/github/release/geocrystal/haversine.svg)](https://github.com/mamgeocrystalantoha/haversine/releases)
[![Docs](https://img.shields.io/badge/docs-available-brightgreen.svg)](https://geocrystal.github.io/haversine/)
[![License](https://img.shields.io/github/license/geocrystal/haversine.svg)](https://github.com/geocrystal/haversine/blob/master/LICENSE)

Crystal implementation of the [Haversine formula](https://en.wikipedia.org/wiki/Haversine_formula) to calculate distances between two points given their latitudes and longitudes.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     haversine:
       github: geocrystal/haversine
   ```

2. Run `shards install`

## Usage

```crystal
require "haversine"
```

Calling `Haversine.distance` with four latitude/longitude coordinates returns a `Haversine::Distance` object which can provide output in kilometers, meters, miles, feet, or nautical miles.

Each "coordinates" member **must** be a pair of coordinates - `latitude` and `longitude`.

`Haversine.distance` accepts of either:

- `Haversine.distance(lat1, lon1, lat2, lon2)`
- `Haversine.distance({lat1, lon1}, {lat2, lon2})`
- `Haversine.distance([lat1, lon1], [lat2, lon2])`

```crystal
# Tokyo -> Paris
distance = Haversine.distance(35.61488, 139.5813, 48.85341, 2.3488)

distance.to_kilometers     # => 9715.470491159029
distance.to_meters         # => 9715470.491159027
distance.to_miles          # => 6032.710918698025
distance.to_feet           # => 31852713.65072557
distance.to_nautical_miles # => 5242.2799481204265
```

If you have latitude/longitude pairs stored in an array or tuple, you can alternately provide two arrays/tuples when calling `Haversine.distance`:

```crystal
london = [51.500153, -0.126236]
new_york = [40.714268, -74.005974]

distance = Haversine.distance(new_york, london)
distance.to_kilometers # => 5570.4744596620685

london = {51.500153, -0.126236}
new_york = {40.714268, -74.005974}

distance = Haversine.distance(new_york, london)
distance.to_kilometers # => 5570.4744596620685
```

Also you can compare `Haversine::Distance` objects:

```crystal
london = [51.500153, -0.126236]
new_york = [40.714268, -74.005974]
shanghai = [31.222220, 121.458060]

distance1 = Haversine.distance(london, new_york)
distance2 = Haversine.distance(london, shanghai)

distance1 < distance2 # => true
```

## Contributing

1. Fork it (<https://github.com/geocrystal/haversine/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Anton Maminov](https://github.com/mamantoha) - creator and maintainer
