require "rspec"
require_relative "../lib/BranchAndBound"
require_relative "../lib/Kingdom"

describe BranchAndBound do

  it "by melo najit optimalni reseni jednoducheho problemu o 4 mestech" do
    file = Tempfile.new("kralovstvi")
    file.write "4\n1 2\n2 3\n3 4\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    bb = BranchAndBound.new(k)
    vysledek = bb.solve


    vysledek.optCriterium.should == 1
    vysledek.solution?.should == true


    file.unlink

  end

  it "by melo uznat nactene reseni za vyhovujici" do
    file = Tempfile.new("kralovstvi")
    file.write "7\n"
    file.write "1 2\n"
    file.write "2 3\n"
    file.write "3 4\n"
    file.write "4 6\n"
    file.write "6 5\n"
    file.write "5 7\n"
    file.write "7 1\n"
    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    bb = BranchAndBound.new(k)
    vysledek = bb.solve


    vysledek.optCriterium.should == 0
    vysledek.solution?.should == true


    file.unlink
  end

  it "by melo najit optimalni reseni problemu kralovstvi bez silnic" do
    file = Tempfile.new("kralovstvi")
    file.write "5\n"

    file.close

    k = Kingdom.new
    k.loadFromFile(file.path)

    bb = BranchAndBound.new(k)
    vysledek = bb.solve

    vysledek.optCriterium.should == 5
    vysledek.solution?.should == true

    file.unlink

  end
end