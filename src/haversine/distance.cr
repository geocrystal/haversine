module Haversine
  class Distance
    include Comparable(self)

    property distance

    def initialize(@distance : Number)
    end

    {% for factor in Haversine::FACTORS.keys %}
      def to_{{factor.id}} : Number
        @distance * Haversine::FACTORS[:{{factor.id}}]
      end
    {% end %}

    def <=>(other : Haversine::Distance)
      distance <=> other.distance
    end

    # Adds the value of `self` to *other*.
    def +(other : Haversine::Distance) : Haversine::Distance
      Haversine::Distance.new(distance + other.distance)
    end

    # Removes the value of *other* from `self`.
    def -(other : Haversine::Distance) : Haversine::Distance
      Haversine::Distance.new(distance - other.distance)
    end
  end
end
