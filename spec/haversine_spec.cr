require "./spec_helper"

describe Haversine do
  it "have version" do
    Haversine::VERSION.should_not be_nil
  end

  describe "#self.distance" do
    describe "returns Haversine::Distance" do
      it { Haversine.distance(0, 0, 0, 0).should be_a(Haversine::Distance) }
      it { Haversine.distance([0.0, 0.0], [0.0, 0.0]).should be_a(Haversine::Distance) }
      it { Haversine.distance({0.0, 0.0}, {0.0, 0.0}).should be_a(Haversine::Distance) }
    end

    describe "calculates the distance between the provided lat/lon pairs" do
      it { Haversine.distance(0, 0, 0, 0).great_circle_distance.should eq(0) }
      it { Haversine.distance([0.0, 0.0], [0.0, 0.0]).great_circle_distance.should eq(0) }
      it { Haversine.distance({0.0, 0.0}, {0.0, 0.0}).great_circle_distance.should eq(0) }
    end

    describe "computes distances correctly" do
      new_york = [40.714268, -74.005974]
      london = [51.500153, -0.126236]

      dist = Haversine.distance(new_york, london)

      it { dist.to_kilometers.should eq(5570.4744596620685) }
      it { dist.to_meters.should eq(5570474.459662069) }
      it { dist.to_miles.should eq(3458.9227691764468) }
      it { dist.to_nautical_miles.should eq(3005.720267276497) }
      it { dist.to_feet.should eq(18263112.22125164) }
    end
  end
end
