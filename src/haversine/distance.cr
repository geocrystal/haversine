module Haversine
  class Distance
    include Comparable(self)

    EARTH_RADIUS = 6371008.8

    FACTORS = {
      kilometers:    EARTH_RADIUS / 1000,
      meters:        EARTH_RADIUS,
      miles:         EARTH_RADIUS / 1609.344,
      feet:          EARTH_RADIUS * 3.28084,
      nauticalmiles: EARTH_RADIUS / 1852,
    }

    property distance

    def initialize(@distance : Number)
    end

    def to_kilometers : Number
      @distance * FACTORS[:kilometers]
    end

    def to_meters : Number
      @distance * FACTORS[:meters]
    end

    def to_miles : Number
      @distance * FACTORS[:miles]
    end

    def to_nautical_miles : Number
      @distance * FACTORS[:nauticalmiles]
    end

    def to_feet : Number
      @distance * FACTORS[:feet]
    end

    def <=>(other : Haversine::Distance)
      distance <=> other.distance
    end
  end
end
