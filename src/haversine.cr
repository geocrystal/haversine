require "./haversine/*"

# The haversine formula determines the great-circle distance between two points on a sphere
# given their latitudes and longitudes.
#
# https://en.wikipedia.org/wiki/Haversine_formula
module Haversine
  RAD_PER_DEG = Math::PI / 180

  # Calculates the haversine distance between two locations using latitude and longitude.
  def self.distance(lat1 : Float64, lon1 : Float64, lat2 : Float64, lon2 : Float64)
    dlon = lon2 - lon1
    dlat = lat2 - lat1

    a = calc(dlat, lat1, lat2, dlon)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    Haversine::Distance.new(c)
  end

  # ditto
  def self.distance(cord1 : Array(Float64), cord2 : Array(Float64))
    lat1, lon1 = cord1
    lat2, lon2 = cord2

    distance(lat1, lon1, lat2, lon2)
  end

  private def self.calc(dlat, lat1, lat2, dlon)
    (Math.sin(rpd(dlat) / 2))**2 + Math.cos(rpd(lat1)) * Math.cos((rpd(lat2))) * (Math.sin(rpd(dlon) / 2))**2
  end

  private def self.rpd(num)
    num * RAD_PER_DEG
  end
end
