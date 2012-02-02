require "rspec"
require "tempfile"
require_relative "../lib/Kingdom"

describe Kingdom do

  it "by mel nacist kralovstvi a spravne urcit parametry kralovstvi" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n1 2\n2 3\n3 4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    k.cityCount.should == 4
    k.cost.should == 10
    k.roadCount.should == 3
    k.optCriterium.should == 0

    file.unlink
  end

  it "by mel poznat, ze nacteny stav neni resenim" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n1 2\n2 3\n3 4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    k.solution?.should == false
    file.unlink
  end

  it "by mel byt schopen vytvorit hlubokou kopii" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n1 2\n2 3\n3 4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    b = k.clone
    k.addNewConnection(3,0)
    k.evaluateConnections

    b.evaluateConnections
    b.cost.should == 10
    b.optCriterium.should == 0

    file.unlink
  end

  it "by pridanim nove silnice k nactenemu stavu mel prepocitat parametry kralovstvi" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n1 2\n2 3\n3 4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    k.addNewConnection(3,0)
    k.evaluateConnections

    k.cost.should == 16
    k.optCriterium.should == 1
    k.roadCount.should == 4

    file.unlink
  end

  it "by mel poznat platne reseni" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    k.addNewConnection(0,1)
    k.addNewConnection(1,2)
    k.addNewConnection(2,3)
    k.addNewConnection(3,0)
    k.evaluateConnections

    k.solution?.should == true

    file.unlink
  end

  it "ziskanim dalsich stavu by melo dojit k ziskani dvou stavu lisicich se o 1 v optimalizacnim kriteriu" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n1 2\n2 3\n3 4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    pole = k.getOtherStates
    pole[1].optCriterium.should == pole[0].optCriterium+1

    file.unlink

  end

end