module Haversine
  class Distance
    include Comparable(self)

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

    property distance

    def initialize(@distance : Number)
    end

    {% for factor in FACTORS.keys %}
      def to_{{factor.id}} : Number
        @distance * FACTORS[:{{factor.id}}]
      end
    {% end %}

    def <=>(other : Haversine::Distance)
      distance <=> other.distance
    end
  end
end
