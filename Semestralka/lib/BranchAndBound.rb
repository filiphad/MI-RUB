require_relative "PriorityQueue"

#Reprezentace systémového prohledávání s prořezávání a výběrem best first
class BranchAndBound

  #Inicializace prohledávání, přijímá počáteční stav
  def initialize(startState)
    @fronta = PriorityQueue.new
    @fronta.push(startState)
    @bestState = nil
    @navstiveno = 0
    @debug = false
  end

  #Zapnutí výpisu rozšířených informací o běhu prohledávání
  def enableDebug
    @debug = true
  end

  #Vypnutí výpisu rozšířených informací o běhu prohledávání
  def disableDebug
    @debug = false
  end

  #Výkoný kód samotného prohledávání
  def solve
    while !(@fronta.empty?)
      stav = @fronta.pop
      #stav.displayConnections
      @navstiveno = @navstiveno + 1
      #@fronta.displayContent
      #stav.displayConnections
      #puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
      if stav.solution?
        if(@bestState == nil)
          @bestState = stav
          if @debug
            puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
            puts "Novy nejlepsi stav"
            print "Pocet silnic k dostaveni: "
            print @bestState.optCriterium
            puts
            @bestState.displayConnections
          end
        else
          if stav.optCriterium < @bestState.optCriterium
            @bestState = stav
            if @debug
              puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
              puts "Novy nejlepsi stav"
              print "Pocet silnic k dostaveni: "
              print @bestState.optCriterium
              puts
              @bestState.displayConnections
            end
          end
        end

        if @bestState.roadCount == @bestState.cityCount
          if @debug
            puts "Konec vypoctu - lepsi reseni nemuze existovat"
          end
          break
        end
      end

      muzeBytLepsi = false
      if @bestState == nil
        muzeBytLepsi = true
      else
        if (stav.optCriterium+1) >= @bestState.optCriterium
          muzeBytLepsi = false
        else
          muzeBytLepsi = true
        end
      end

      if muzeBytLepsi
        pole = stav.getOtherStates
        if pole != nil
          @fronta.pushArray(pole)
        end
      end

    end
    if @debug
      print "Behem vypoctu bylo navstiveno "
      print @navstiveno
      print " stavu."
      puts
    end
    return @bestState
  end
end