Infinity = 1.0/0


#Třída reprezentující silniční síť celého království
class Kingdom

  attr_reader :optCriterium, :cost, :cityCount, :roadCount

  def initialize(cityCount=0, roads=[], i=0, j=0)
    @cityCount = cityCount
    @roads = []
    @optCriterium = Infinity
    @roadCount = Infinity
    @cost = 0
    @i = i
    @j = j

    roads.each { |tmp|
      nova = []
      tmp.each { |polozka|
        nova << polozka
      }
      @roads << nova
    }
  end

  #Tvorba hluboké kopie
  def clone
    Kingdom.new(@cityCount, @roads, @i, @j)
  end

  #Načtení silniční sítě ze souboru
  def loadFromFile(filename)
    begin
      File.open(filename, "r") { |f|
        radka = 0
        roadCount = 0
        f.each { |line|
          if radka == 0
            @cityCount = Integer(line)
            if @cityCount <= 0
              raise
            end
            @cityCount.times do |i|
              @roads << []
              @cityCount.times do |j|
                @roads[i][j] = :noConnection
                if i == j
                  @roads[i][j] = :selfConnection
                end
              end
            end
          end

          if radka > 0
            cesta = []
            cesta = line.split(' ')
            start = Integer(cesta[0])-1
            if start < 0
              raise
            end
            if start >= @cityCount
              raise
            end
            cil = Integer(cesta[1])-1
            if cil < 0
              raise
            end

            if cil >= @cityCount
              raise
            end

            #p cesta
            @roads[start][cil] = :directConnection
          end

          radka = radka + 1

        }
      }
      evaluateConnections
    rescue
      raise "Neplatny format souboru"
    end

  end

  #Zadání silniční sítě uživatelem do konzole
  def loadFromUser
    loop do
      print "Zadejte prosim pocet mest: "
      begin
        mest = gets
        @cityCount = Integer(mest)
        if @cityCount <= 0
          raise
        end

        @cityCount.times do |i|
          @roads << []
          @cityCount.times do |j|
            @roads[i][j] = :noConnection
            if i == j
              @roads[i][j] = :selfConnection
            end
          end
        end


        break
      rescue
        puts "Neplatny vstup, opakujte prosim zadani"
      end
    end

    pocetSilnic = 0

    loop do
      print "Zadejte prosim pocet existujicich silnic: "
      begin
        silnic = gets
        pocetSilnic = Integer(silnic)
        if pocetSilnic < 0
          raise
        end
        break
      rescue
        puts "Neplatny vstup, opakujte prosim zadani"
      end
    end

    pocetSilnic.times {
      start = 0
      cil = 0

      loop do
        begin
          print "Zadejte prosim mesto, kde silnice zacina (1-"
          print @cityCount
          print "): "

          pocatek = gets
          start = Integer(pocatek)
          if start < 1
            raise
          end

          if start > @cityCount
            raise
          end

          print "Zadejte prosim mesto, kde silnice konci (1-"
          print @cityCount
          print "): "

          konec = gets
          cil = Integer(konec)
          if cil < 1
            raise
          end

          if cil > @cityCount
            raise
          end

          if start == cil
            raise
          end

          @roads[start-1][cil-1] = :directConnection

          break
        rescue
          puts "Neplatny vstup, opakujte prosim zadani"
        end
      end


    }

    evaluateConnections
    puts "Pocatecni stav silnicni site"
    displayConnections

  end

  #Vykreslení matice sousednosti
  def displayConnections
    i = 1
    print "  "
    @cityCount.times {
      print i
      print " "
      i = i+1
    }
    puts

    i = 1
    @roads.each { |tmp|
      print i
      print " "
      i = i+1
      tmp.each { |spojeni|

        if (spojeni == :directConnection)
          print("D")
        end
        if (spojeni == :noConnection)
          print(" ")
        end
        if (spojeni == :indirectConnection)
          print("I")
        end
        if (spojeni == :newConnection)
          print("A")
        end
        if (spojeni == :selfConnection)
          print("X")
        end
        print(" ")
      }
      puts
    }
  end

  #Vyhodnocení možných cest mezi všemi městy
  def evaluateConnections
    for k in 0..@cityCount-1
      for i in 0..@cityCount-1
        for j in 0..@cityCount-1
          if @roads[i][j] == :noConnection
            if (@roads[i][k] != :noConnection) && (@roads[k][j] != :noConnection)
              @roads[i][j] = :indirectConnection
            end
          end
        end
      end
    end


    @cost = 0
    pridano = 0
    @roadCount = 0
    @roads.each { |tmp|
      tmp.each { |spojeni|
        if spojeni != :noConnection
          @cost = @cost + 1
        end
        if spojeni == :newConnection
          pridano = pridano + 1
        end
        if spojeni == :directConnection
          @roadCount = @roadCount + 1
        end
      }
    }

    @optCriterium = pridano
    @roadCount = @roadCount + @optCriterium

  end

  #Přidání nové silnice
  def addNewConnection(start, cil)
    @roads[start][cil] = :newConnection
  end

  #Získání dalších stavů pro prohledávání
  def getOtherStates
    result = []
    if @i >= @cityCount
      return nil
    end

    for i in @i..@cityCount-1
      for j in @j..@cityCount-1
        #print i
        #print " "
        #print j
        #puts
        if @roads[i][j] == :noConnection
          @i = i
          @j = j+1
          if @j == @cityCount
            @j = 0
            @i = @i+1
          end
          novy = self.clone
          novy.addNewConnection(i, j)
          novy.evaluateConnections
          result << self
          result << novy
          return result
        end
      end
      @j = 0
    end
    return nil
  end


  #Lze se ze všech měst dostat kamkoliv?
  def solution?
    return @cost == @cityCount*@cityCount
  end

  #Vypsání výsledků po ukončení prohledávání
  def printResult
    if solution?
      if optCriterium == 0
        puts "Silnicni sit je vyhovujici."
      else
        print "Je potreba dostavet silnice"
        i = 1
        @roads.each { |tmp|
          j = 1
          tmp.each { |spojeni|
            if spojeni == :newConnection
              print " <"
              print i
              print ","
              print j
              print ">"
            end
            j = j+1
          }
          i = i+1
        }
      end
    else
      puts "Stav neni resenim."
    end
  end

end