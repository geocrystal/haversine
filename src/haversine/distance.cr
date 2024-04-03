module Haversine
  class Distance
    include Comparable(self)

    EARTH_RADIUS = 6371008.8

    FACTORS = {
      kilometers:     EARTH_RADIUS / 1000,
      meters:         EARTH_RADIUS,
      miles:          EARTH_RADIUS / 1609.344,
      feet:           EARTH_RADIUS * 3.28084,
      nautical_miles: EARTH_RADIUS / 1852,
    }

    property distance

    def initialize(@distance : Number)
    end

    {% for factor in ["meters", "kilometers", "miles", "nautical_miles", "feet"] %}
      def to_{{factor.id}} : Number
        @distance * FACTORS[:{{factor.id}}]
      end
    {% end %}

    def <=>(other : Haversine::Distance)
      distance <=> other.distance
    end
  end
end
