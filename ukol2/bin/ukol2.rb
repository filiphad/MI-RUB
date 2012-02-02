require_relative "../lib/Ctverec"

chyba = false

begin
  print "Zadejte delku hrany prvniho ctverce: "
  vstup = gets
  a = Float(vstup)
  if a<0
    raise
  end
  print "Zadejte x-ovou souradnici stredu prvniho ctverce: "
  vstup = gets
  x = Float(vstup)
  print "Zadejte y-ovou souradnici stredu prvniho ctverce: "
  vstup = gets
  y = Float(vstup)

  ctvA = Ctverec.new(x,y,a)

  print "Zadejte delku hrany druheho ctverce: "
  vstup = gets
  a = Float(vstup)
  if a < 0
    raise
  end
  print "Zadejte x-ovou souradnici stredu druheho ctverce: "
  vstup = gets
  x = Float(vstup)
  print "Zadejte y-ovou souradnici stredu druheho ctverce: "
  vstup = gets
  y = Float(vstup)

  ctvB = Ctverec.new(x,y,a)

rescue
  puts "Spatny vstup."
  chyba = true
end

if chyba == false
  begin
    obsah = sjednoceni(ctvA,ctvB)
    print "Obsah sjednoceni dvou ctvercu je "
    print obsah
    print ".\n"
  rescue
    puts "Ctverce se ani nedotykaji."
  end
end




