module Movable
  attr_accessor :initial_position, :speed
end

module Timable
  attr_accessor :time
  include Movable
  def position
    initial_position + speed * time
  end
end

class Car
  include Timable
end


ferrari = Car.new
ferrari.initial_position = 0
ferrari.speed = 300
ferrari.time = 10
puts ferrari.position # 3_000