module Haversine
  class Distance
    include Comparable(self)

    GREAT_CIRCLE_RADIUS_KILOMETERS     = 6371
    GREAT_CIRCLE_RADIUS_METERS         = GREAT_CIRCLE_RADIUS_KILOMETERS * 1000
    GREAT_CIRCLE_RADIUS_MILES          = 3956
    GREAT_CIRCLE_RADIUS_FEET           = GREAT_CIRCLE_RADIUS_MILES * 5280
    GREAT_CIRCLE_RADIUS_NAUTICAL_MILES = GREAT_CIRCLE_RADIUS_MILES / 1.15078

    property great_circle_distance

    def initialize(@great_circle_distance : Float64)
    end

    def to_kilometers
      @great_circle_distance * GREAT_CIRCLE_RADIUS_KILOMETERS
    end

    def to_meters
      @great_circle_distance * GREAT_CIRCLE_RADIUS_METERS
    end

    def to_miles
      @great_circle_distance * GREAT_CIRCLE_RADIUS_MILES
    end

    def to_nautical_miles
      @great_circle_distance * GREAT_CIRCLE_RADIUS_NAUTICAL_MILES
    end

    def to_feet
      @great_circle_distance * GREAT_CIRCLE_RADIUS_FEET
    end

    def <=>(other : Haversine::Distance)
      great_circle_distance <=> other.great_circle_distance
    end
  end
end
