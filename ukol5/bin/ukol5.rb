require_relative "../lib/Segment"
require_relative "../lib/TestCase"


sad = Integer(gets)

i=0

sady = []
while i<sad
  gets
  sada = TestCase.new(0)
  sada.loadVstup
  sady << sada

  i = i+1
end

sady.each{|sada|
  sada.findSolution
}



