
vstup = String.new
vstup = gets
pocetGrafu = Integer(vstup)

Infinity = 1.0/0

class Fronta
  def initialize
    @pole = []
  end

  public
  def push(uzel)
    @pole << uzel
  end

  def pop
    uzlik = @pole[0]
    @pole.delete_at(0)
    return uzlik
  end

  def empty?
    return @pole.empty?
  end

  def to_s
    return "Fronta: #{@pole.to_s}"
  end
end


class Uzel
  attr_accessor :id, :adj, :stav, :d, :p
  def initialize(id)
    @id=id
    @adj = []
    @stav = :FRESH
    #@d = Infinity
    #@p = nil
  end

  public
  def BFS
    @stav = :OPEN
   # @d = 0
   # @p = nil

    qu = Fronta.new
    #puts self
    #puts self.object_id
    qu.push(self)

    prvni = true

    while !qu.empty?
      u = qu.pop
      #puts qu
      u.adj.each{ |v|
        #p v

        if v.stav == :FRESH
          v.stav = :OPEN
       #   v.d = u.d+1
       #   v.p = u
          qu.push(v)
        end
      }
      u.stav = :CLOSED
      if !prvni
         print " "
      end
      print u.id
      prvni = false


    end

    print "\n"



    #1 void BFS (Graph G, Node s) {
    #2   for (Node u in U(G)-s)
    #3     { stav[u] = FRESH; d[u] = nekonečno; p[u] = null; }
    #4   stav[s] = OPEN; d[s] = 0; p[s] = null;
    #5   Queue.Init(); Queue.Push(s);
    #6   while (!Queue.Empty()) {
    #7     u = Queue.Pop();
    #8     for (v in Adj[u]) {
    #9        if (stav[v] == FRESH) {
    #10         stav[v] = OPEN; d[v] = d[u]+1;
    #11         p[v] = u; Queue.Push(v);
    #12       }
    #13     }
    #14     stav[u]=CLOSED;
    #15   }
    #16 }


  end

  def DFS

    if !@prvni
         print " "
    end

    print @id
    @prvni = false

    @stav = :OPEN
    @adj.each{ |v|
        if v.stav == :FRESH
        #  v.p = self
          v.DFS
        end
    }
    @stav = :CLOSED



    #void DFS-Projdi(Node u) {
#1    stav[u] = OPEN; d[u] = ++i;
#2    for (Node v in Adj[u])
#3      if (stav[v] == FRESH)  {
#4        p[v] = u;  DFS-Projdi(v); }
#5    stav[u] = CLOSED; f[u] = ++i;
#6  }#

  end

  def DFSstart
    @prvni = true
    self.DFS
    print "\n"
  end
end

def najdi(uzly, id)
  uzly.each_with_index{|uzlik, index|
     if uzlik.id == id
       return uzly[index]
     end
  }
end


# fro = Fronta.new
# fro.push(Uzel.new("5"))
#puts fro


for i in 1..pocetGrafu
  vstup = gets
  pocetUzlu = Integer(vstup)

  uzly = Array.new

  puts "graph #{i}"


  specUzlu = Array.new
  for ii in 0..pocetUzlu-1
    vstup = gets
    pole = vstup.split(' ')
    specUzlu << pole
  end

  #p specUzlu

  specUzlu.each{ |pole|
    uzly << Uzel.new(pole[0])
  }

  cisloU = 0
  #p specUzlu
  specUzlu.each{ |pole|
    for iii in 0..(Integer(pole[1])-1)
      uzly[cisloU].adj << najdi(uzly, pole[2+iii])
    end
    cisloU = cisloU + 1
  }

  #p uzly

  #uzly jsou naladovany

  pokracujem = true
  while pokracujem
    vstup = gets
    pole = vstup.split(' ')

    if (pole[0] == "0") && (pole[1] == "0")
      pokracujem = false
      break
    end

    if(pole[1] == "0")
      najdi(uzly, pole[0]).DFSstart
    end
    if(pole[1] == "1")
      najdi(uzly, pole[0]).BFS
    end

    uzly.each{ |uzel|
      uzel.stav = :FRESH
      #uzel.p = nil
      #uzel.d = Infinity
    }

  end





end



