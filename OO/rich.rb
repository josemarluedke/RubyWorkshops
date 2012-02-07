#Encoding: UTF-8
class Rich
  attr_reader :name, :fortune, :age, :born, :companies
  
  def initialize *args
    @name, @fortune, @age, @born, @companies = args
  end
  
  def richer_than? rich
    return true unless rich.respond_to? :fortune
    fortune > rich.fortune
  end
end

slim = Rich.new "Slim", 74, 71, "Mexico", ["Telmex", "América Móvil", "Grupo Carso"]
gates = Rich.new "Gates", 56, 56, "U.S.", ["Microsoft"]
mittal = Rich.new "Mittal", 31, 60, "India", ["Arcelor Mittal"]
eike = Rich.new "Eike", 30, 53, "Brasil", ["EBX Group"]

puts gates.richer_than? eike
puts mittal.richer_than? slim