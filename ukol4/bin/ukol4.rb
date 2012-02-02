require_relative "../lib/Decipher"


soubor = "vstup.txt"
puts "Zadejte posun retezce"
begin
  posun = Integer(gets)
  decipher(posun, soubor)
rescue
  puts "Vstup neni cislo !!!"
end






