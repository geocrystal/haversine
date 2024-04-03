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
      it { Haversine.distance(0, 0, 0, 0).distance.should eq(0) }
      it { Haversine.distance([0.0, 0.0], [0.0, 0.0]).distance.should eq(0) }
      it { Haversine.distance({0.0, 0.0}, {0.0, 0.0}).distance.should eq(0) }
    end

    describe "computes distances correctly" do
      new_york = [40.714268, -74.005974]
      london = [51.500153, -0.126236]

      dist = Haversine.distance(new_york, london)

      it { dist.to_kilometers.should eq(5570.482153929098) }
      it { dist.to_meters.should eq(5570482.153929098) }
      it { dist.to_miles.should eq(3461.3371373237155) }
      it { dist.to_nautical_miles.should eq(3007.8197375427094) }
      it { dist.to_feet.should eq(18275860.669896744) }
    end
  end
end
