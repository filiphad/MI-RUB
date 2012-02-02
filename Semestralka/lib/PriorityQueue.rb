#Třída pro reprezentaci prioritní fronty
class PriorityQueue

  def initialize
    @data = []
  end

  #Vložit objekt do prioritní fronty
  def push(stav)
    @data << stav
    @data.sort!{|x,y|
      x.cost<=>y.cost
    }
    @data.reverse!
  end

  #Vložit pole objektů do prioritní fronty
  def pushArray(stavy)
    stavy.each{|stav|
      @data << stav
    }
    @data.sort!{|x,y|
      x.cost<=>y.cost
    }
    @data.reverse!
  end

  #Vybrat objekt s nejvyšší cenou z prioritní fronty
  def pop
    if !@data.empty?
      tmp = @data[0]
      @data.delete_at(0)
      return tmp
    end
  end

  #Je prioritní fronta prázdná?
  def empty?
    return @data.empty?
  end

  #Vypiš obsah prioritní fronty
  def displayContent
    @data.each{|tmp|
      print tmp.cost
      print " "
    }
    puts
  end


end