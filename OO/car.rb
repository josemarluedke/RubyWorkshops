class Car
  attr_reader :brand, :speed
  
  def initialize *args
    @brand, @speed = args
  end
  
  def ms_speed
    speed / 3.6
  end
end