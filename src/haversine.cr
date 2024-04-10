# The haversine formula determines the great-circle distance between two points on a sphere
# given their latitudes and longitudes.
#
# https://en.wikipedia.org/wiki/Haversine_formula
module Haversine
  extend self

  EARTH_RADIUS = 6371008.8

  # Unit of measurement factors using a spherical (non-ellipsoid) earth radius.
  #
  # Keys are the name of the unit, values are the number of that unit in a single radians
  FACTORS = {
    centimeters:    EARTH_RADIUS * 100,
    centimetres:    EARTH_RADIUS * 100,
    degrees:        360 / (2 * Math::PI),
    feet:           EARTH_RADIUS * 3.28084,
    inches:         EARTH_RADIUS * 39.37,
    kilometers:     EARTH_RADIUS / 1000,
    kilometres:     EARTH_RADIUS / 1000,
    meters:         EARTH_RADIUS,
    metres:         EARTH_RADIUS,
    miles:          EARTH_RADIUS / 1609.344,
    millimeters:    EARTH_RADIUS * 1000,
    millimetres:    EARTH_RADIUS * 1000,
    nautical_miles: EARTH_RADIUS / 1852,
    radians:        1,
    yards:          EARTH_RADIUS * 1.0936,
  }

  alias Number = Int32 | Float32 | Float64

  RAD_PER_DEG = Math::PI / 180

  # Calculates the haversine distance between two locations using latitude and longitude.
  def distance(lat1 : Number, lon1 : Number, lat2 : Number, lon2 : Number) : Haversine::Distance
    dlon = lon2 - lon1
    dlat = lat2 - lat1

    a = calc(dlat, lat1, lat2, dlon)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    Haversine::Distance.new(c)
  end

  # :ditto:
  def distance(coord1 : Array(Number), coord2 : Array(Number)) : Haversine::Distance
    lat1, lon1 = coord1
    lat2, lon2 = coord2

    distance(lat1, lon1, lat2, lon2)
  end

  # :ditto:
  def distance(coord1 : Tuple(Number, Number), coord2 : Tuple(Number, Number)) : Haversine::Distance
    lat1, lon1 = coord1
    lat2, lon2 = coord2

    distance(lat1, lon1, lat2, lon2)
  end

  # Takes the staring point by `latitude`, `longitude` and calculates the location of a destination point
  # given a `distance` factor in `Haversine::FACTORS`; and `bearing` in degrees(ranging from -180 to 180).
  #
  # https://github.com/Turfjs/turf/blob/master/packages/turf-destination/index.ts
  def destination(latitude : Number, longitude : Number, distance : Float64, bearing : Float64, unit : Symbol = :kilometers) : Tuple(Float64, Float64)
    factor = FACTORS[unit]

    radians = distance / factor
    bearing_rad = to_radians(bearing)

    latitude1 = to_radians(latitude)
    longitude1 = to_radians(longitude)

    latitude2 = Math.asin(
      Math.sin(latitude1) * Math.cos(radians) +
      Math.cos(latitude1) * Math.sin(radians) * Math.cos(bearing_rad)
    )

    longitude2 =
      longitude1 +
        Math.atan2(
          Math.sin(bearing_rad) * Math.sin(radians) * Math.cos(latitude1),
          Math.cos(radians) - Math.sin(latitude1) * Math.sin(latitude2)
        )

    {to_degrees(latitude2), to_degrees(longitude2)}
  end

  # :ditto:
  def destination(coord : Array(Number), distance : Float64, bearing : Float64, unit : Symbol = :kilometers) : Tuple(Float64, Float64)
    latitude, longitude = coord

    destination(latitude, longitude, distance, bearing, unit)
  end

  # :ditto:
  def destination(coord : Tuple(Number, Number), distance : Float64, bearing : Float64, unit : Symbol = :kilometers) : Tuple(Float64, Float64)
    latitude, longitude = coord

    destination(latitude, longitude, distance, bearing, unit)
  end

  private def calc(dlat : Number, lat1 : Number, lat2 : Number, dlon : Number) : Number
    (Math.sin(rpd(dlat) / 2)) ** 2 + Math.cos(rpd(lat1)) * Math.cos((rpd(lat2))) * (Math.sin(rpd(dlon) / 2)) ** 2
  end

  private def rpd(num : Number) : Number
    num * RAD_PER_DEG
  end

  private def to_radians(degrees : Float64) : Float64
    degrees * Math::PI / 180.0
  end

  private def to_degrees(radians : Float64) : Float64
    radians * 180.0 / Math::PI
  end
end

require "./haversine/*"
