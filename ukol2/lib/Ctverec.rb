class Ctverec
  attr_accessor :x, :y, :a

  def initialize(x, y, a)
    @x = x
    @y = y
    @a = a
  end
end

def sjednoceni(a, b)
  rozdil_x = (a.x-b.x).abs
  rozdil_y = (a.y-b.y).abs

  prekryv_x = rozdil_x-a.a/2-b.a/2
  prekryv_y = rozdil_y-a.a/2-b.a/2

  if(prekryv_x > 0)
    raise
  end

  if(prekryv_y > 0)
    raise
  end

  plocha = a.a*a.a + b.a*b.a - prekryv_x*prekryv_y
  return plocha
end
