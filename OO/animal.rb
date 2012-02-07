class Animal
  @@fastest = nil
  @@slowest = nil
  attr_reader :species, :max_speed
  def initialize *args
    @species, @max_speed = args
    if ! @@fastest
      @@fastest = self
      @@slowest = self
    elsif max_speed > @@fastest.max_speed
      @@fastest = self
    elsif max_speed < @@slowest.max_speed
      @@slowest = self
    end
  end
  
  def self.fastest
    @@fastest
  end
  
  def self.slowest
    @@slowest
  end
end


Animal.new "Puma", 300
Animal.new "Turtle", 100

puts Animal.fastest.species
puts Animal.slowest.species