#Encoding: UTF-8
class Rich
  attr_reader :name, :fortune, :age, :born, :companies
  
  def initialize *args
    @name, @fortune, @age, @born, @companies = args
  end
  
  def richer_than? rich, year
    return true unless rich.respond_to? :fortune
    fortune[year] > rich.fortune[year]
  end
  
  def difference start_year, end_year
    fortune[end_year] - fortune[start_year]
  end
end

slim = Rich.new "Slim", {2009 => 35, 2010 => 53.5, 2011 => 74}, 71, "Mexico", ["Telmex", "América Móvil", "Grupo Carso"]
gates = Rich.new "Gates", {2009 => 40, 2010 => 53, 2011 => 56}, 56, "U.S.", ["Microsoft"]

puts gates.fortune[2009]
puts gates.fortune[2010]
puts gates.fortune[2011]

puts gates.richer_than? slim, 2009
puts gates.richer_than? slim, 2010

puts gates.difference 2009, 2010
puts gates.difference 2009, 2011