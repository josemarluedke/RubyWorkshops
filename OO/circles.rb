# some helperz
def point *xy
  Point.new *xy
end

def circle x, y, r
  Circle.new(point(x, y), r)
end

class Point
  attr_reader :x, :y
  def initialize x, y
    @x = x
    @y = y
  end
  def distance point
    xd = (x - point.x).abs
    yd = (y - point.y).abs
    Math.hypot xd, yd # Math.sqrt(xd ** 2 + yd ** 2)
  end
  def === circle
    circle.include?(self)
  end
end
# require 'active_support'
class Circle
  # delegate :x, to: :center
  attr_reader :center, :radius
  def initialize center, radius
    @center = center
    @radius = radius
  end
  def x
    center.x
  end
  def y
    center.y
  end
  def include? point
    center.distance(point) < radius
  end
  def <=> circle # delegate?
    area <=> circle.area
  end
  def area
    radius * Math::PI
  end
  def bounds
    (0..360).map do |gr|
      x = center.x + radius * Math.sin(gr)
      y = center.y + radius * Math.cos(gr)
      Point.new x, y
    end
  end
  def distance_from point
    Math.cos(center.x - point.x) + Math.sin(center.y - point.y)
    Math.sqrt(x + y)
  end
  
  def diameter
    radius * 2
  end
  
  def intersect? other_circle
    center.distance(other_circle.center) - other_circle.radius < radius
  end
  
  def inside? other_circle
    other_circle.center.distance(center) + radius <= other_circle.radius
  end
  
  def outside? other_circle
    other_circle.center.distance(center) - radius > other_circle.radius
  end
  
  def succ
    Circle.new center, radius + 1
  end
end

class Donut
  attr_reader :center, :radius, :circles
  def initialize *args
    if args[0].instance_of? Circle and args[1].instance_of? Circle
      if args[0].inside? args[1]
        @circles = [args[1], args[0]]
      elsif args[1].inside? args[0]
        @circles = [args[0], args[1]]
      end
    elsif args[0].instance_of? Point
      
      if args[1].to_f > args[2].to_f
        r1 = args[1].to_f
        r2 = args[2].to_f
      else
        r1 = args[2].to_f
        r2 = args[1].to_f
      end
      @circles = [Circle.new(args[0], r1), Circle.new(args[0], r1)]
    end
  end
  
  def area
    circles[0].area - circles[1].area
  end
  
  def distance_from point
    circles[0].center.distance point
  end
  
  def bounds
    {internals: circles[1].bounds, externals: circles[0].bounds}
  end
  
  def intersect? other
    other = other.circles[0] if other.instance_of? Donut
    other.intersect?(circles[0]) and not other.inside? circles[1]
  end
  
  def inside? other
    other = other.circles[0] if other.instance_of? Donut
    other.inside?(circles[0]) and other.outside? circles[1]
  end
  
  def x
    circles[0].center.x
  end
  def y
    circles[0].center.y
  end
  def include? point
    circles[0].include? point and not circles[1].include? point
  end
  def <=> other # delegate?
    area <=> other.area
  end
  def diameter
    circles[0].diameter
  end
end

# c1 = circle(0,0,5)
# c2 = circle(10,0,6)
# puts c1.intersect? c2
# 
# c3 = circle(5,5,2)
# c4 = circle(10,5,7)
# puts c3.inside? c4

 # c5 = circle(0,0,0) 
 # c6 = circle(10,10,10) 
 # puts (c5..c6).to_a

#d1 = Donut.new Circle.new(Point.new(0, 0), 10), Circle.new(Point.new(0, 0), 4)
#d2 = Donut.new Circle.new(Point.new(0, 0), 4), Circle.new(Point.new(0, 0), 2)

#puts d1.intersect? Circle.new(Point.new(5, 5), 2)
#puts d1.intersect? d2
#puts d1.inside? Circle.new(Point.new(7, 0), 2)