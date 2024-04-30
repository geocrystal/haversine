require "../spec_helper"

describe Haversine::Distance do
  describe "<=>" do
    context "equality" do
      it "is true when the great circle distance is equal" do
        dist1 = Haversine::Distance.new(0)
        dist2 = Haversine::Distance.new(0)
        (dist1 == dist2).should be_true
      end

      it "is false when the great circle distance is not equal" do
        dist1 = Haversine::Distance.new(0)
        dist2 = Haversine::Distance.new(1)
        (dist1 == dist2).should be_false
      end
    end
  end

  describe "operations" do
    dist1 = Haversine::Distance.new(2)
    dist2 = Haversine::Distance.new(1)

    it { (dist1 + dist2).distance.should eq(3) }
    it { (dist1 - dist2).distance.should eq(1) }
    it { [dist1, dist2].sum.distance.should eq(3) }
  end
end
