def decipher(posun, soubor)
  File.open(soubor, "r"){|f|
    f.each{|line|
      pismenka = line.split('');
      pismenka.each{|char|
        #puts char.ord
        if (char!="\n") && (char!="\r")
          znak = char.ord
          znak = znak - 32
          znak = znak+posun
          znak = znak%94
          znak = znak + 32
          print znak.chr
        end
       }
      print "\n"
     }
   }
end