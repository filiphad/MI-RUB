require_relative("../lib/Kingdom")
require_relative("../lib/PriorityQueue")
require_relative("../lib/BranchAndBound")



puts "Semestralni prace z MI-RUB"
puts "Cesta tam a zase zpatky"
puts "Filip Michl, michlfil@fit.cvut.cz"
puts

volba = 0

loop do
  puts "Pro vstup ze souboru zadejte 1,"
  puts "pro prime zadani silnicni site zadejte 2,"
  puts "pro ukonceni programu zadejte 0."

  begin
    volba = Integer(gets)
    if volba < 0
      raise
    end
    if volba > 2
      raise
    end
    break
  rescue
    puts "Neplatan volba, prosim opakujte zadani"
  end
end

a = Kingdom.new

if volba == 1
  loop do
    puts "Zadejte prosim nazev souboru"
    begin
      soubor = gets.chop
      a.loadFromFile(soubor)
      break
    rescue
      puts "Zadany soubor neobsahuje platne zadani, prosim zvolte jiny"
    end
  end

end

if volba == 2
  a.loadFromUser
end

if volba > 0
  bb = BranchAndBound.new(a)
  bb.enableDebug
  result = bb.solve
  if result == nil
    puts "Uloha nema reseni"
  else
    result.printResult
  end
end


