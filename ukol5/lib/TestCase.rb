require_relative "Segment"

class TestCase
  attr_accessor :m

  def initialize(m)
    @m = m
    @segmenty = Array.new
    @best = nil
  end

  def res(konfigurace, i)
   #p konfigurace
   #p @best
    if i>(@segmenty.length)
      return
    end
    if @best == nil
      reseni = solution?(konfigurace)
      if reseni==true
         @best = konfigurace
       end
       novas = konfigurace.clone
       novas << @segmenty[i]
       res(novas, i+1)
       res(konfigurace,i+1)
     else
        if @best.length > konfigurace.length
          reseni = solution?(konfigurace)
          if reseni==true
            @best = konfigurace
          end
          novas = konfigurace.clone
          novas << @segmenty[i]
          res(novas, i+1)
          res(konfigurace,i+1)
        end
     end
  end

    def solution?(konfigurace)
      max = 0
      konfigurace = konfigurace.sort_by{|fn|
          fn.l
      }
      konfigurace.each{ |aktual|
        if (max < aktual.r) && (aktual.l<=max)
          max = aktual.r
        end
      }

      return (max>=@m)
    end

  public
  def addSegment(segment)
    @segmenty << segment
  end

  def findSolution
    res([], 0)

    if @best == nil
      puts "0"
    else
      puts @best.length
      @best.each{ |a|
        print a.l
        print " "
        puts a.r
      }
    end
    puts
  end

  def loadVstup
     @m = Integer($stdin.gets)
     konec = false
     while konec == false
       vstup = $stdin.gets
       pole = vstup.split(' ')
       pole[0] = Integer(pole[0])
       pole[1] = Integer(pole[1])
       if((pole[0]==0) && (pole[1])==0)
         konec = true
         break
       end
       addSegment(Segment.new(pole[0], pole[1]))
     end
  end

end