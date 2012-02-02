require "rspec"
require_relative "../lib/Segment"

describe Segment do

  it "by mel obsahovat hodnoty zadane pri inicializaci" do

    s = Segment.new(4,5)
    s.l.should == 4
    s.r.should == 5
  end
end