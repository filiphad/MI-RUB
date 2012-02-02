require "rspec"
require_relative "../lib/PriorityQueue"

describe "PriorityQueue" do

  it "should be empty at start" do
    pq = PriorityQueue.new
    pq.empty?.should == true
  end

  it "nemela by byt prazda, pokud do ni vlozim jeden objekt" do
    pq = PriorityQueue.new
    class TestovaciObjekt
      attr_reader :cost

      def initialize(cena)
        @cost = cena
      end
    end

    to = TestovaciObjekt.new(10)
    pq.push(to)
    pq.empty?.should == false

  end

  it "nemela by byt prazda, pokud do ni vlozim pole objektu" do
    pq = PriorityQueue.new
    class TestovaciObjekt
      attr_reader :cost

      def initialize(cena)
        @cost = cena
      end
    end

    pole = []
    pole << TestovaciObjekt.new(1)
    pole << TestovaciObjekt.new(2)
    pole << TestovaciObjekt.new(3)

    pq.pushArray(pole)
    pq.empty?.should == false
  end

  it "vlozeny objekt by mel jit vyjmout" do
    pq = PriorityQueue.new
    class TestovaciObjekt
      attr_reader :cost

      def initialize(cena)
        @cost = cena
      end
    end

    tmp = TestovaciObjekt.new(5)
    pq.push(tmp)
    tmp2 = pq.pop
    tmp.should == tmp2
  end

  it "objekty by se mely vracet sestupne podle ceny pro push" do
    pq = PriorityQueue.new
    class TestovaciObjekt
      attr_reader :cost

      def initialize(cena)
        @cost = cena
      end
    end

    to1 = TestovaciObjekt.new(1)
    to2 = TestovaciObjekt.new(2)
    to3 = TestovaciObjekt.new(3)

    pq.push(to1)
    pq.push(to2)
    pq.push(to3)

    pq.pop.should == to3
    pq.pop.should == to2
    pq.pop.should == to1
  end

  it "objekty by se mely vracet sestupne podle ceny pro pushArray" do
    pq = PriorityQueue.new
    class TestovaciObjekt
      attr_reader :cost

      def initialize(cena)
        @cost = cena
      end
    end

    pole = []
    pole << TestovaciObjekt.new(1)
    pole << TestovaciObjekt.new(2)
    pole << TestovaciObjekt.new(3)

    pq.pushArray(pole)

    pq.pop.should == pole[2]
    pq.pop.should == pole[1]
    pq.pop.should == pole[0]
  end

end