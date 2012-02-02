require "rspec"
require_relative "../lib/Ctverec"

describe "Ctverec" do

  it "by mel po inicializaci obsahovat spravne hodnoty" do
    ct = Ctverec.new(1,2,3)
    ct.x.should == 1
    ct.y.should == 2
    ct.a.should == 3
  end

  it "by mel urcit sjednoceni dotykajicich se ctvercu" do
    a = Ctverec.new(1,1,2)
    b = Ctverec.new(3,1,2)
    vysl = sjednoceni(a,b)
    vysl.should == 8
  end

  it "by mel urcit sjednoceni prekryvajicich se ctvercu" do
    a = Ctverec.new(1,1,2)
    b = Ctverec.new(2,1,2)
    vysl = sjednoceni(a,b)
    vysl.should == 6
  end
end

