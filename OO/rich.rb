#Encoding: UTF-8
class Rich
  attr_reader :name, :fortune, :age, :born, :companies
  @@list_rich = []
  def initialize *args
    @name, @fortune, @age, @born, @companies = args
    @@list_rich << self
  end
  
  def richer_than? rich, year
    return true unless rich.respond_to? :fortune
    fortune[year] > rich.fortune[year]
  end
  
  def difference start_year, end_year
    fortune[end_year] - fortune[start_year]
  end
  
  def rank year
    rich = @@list_rich.sort { |a, b| b.fortune[year] <=> a.fortune[year] }
    rich.index(self) + 1
  end
  
  def forecast year
    fortunes = []
    fortune.values.each {|f| fortunes << f.to_f } # Convert to float
    (((fortunes[1] / fortunes[0]) + (fortunes[2] / fortunes[1])) / 2 * fortunes[2]).round 2
  end
  
  def self.est year
    rank(year)[0]
  end
  
  def self.rank year
    @@list_rich.sort { |a, b| b.fortune[year] <=> a.fortune[year] }
  end
  
  def self.older
    older = @@list_rich.sort { |a, b| b.age <=> a.age }.first
    rank = rank(last_year)
    rank[rank.index(older)]
  end
  
  def self.younger
    younger = @@list_rich.sort { |a, b| a.age <=> b.age }.first
    rank = rank(last_year)
    rank[rank.index(younger)]
  end
  
private
  def self.last_year
    years = []
    for rich in @@list_rich
      years << rich.fortune.keys
    end
    years.flatten.uniq.sort.last
  end
end


slim = Rich.new "Slim", {2009 => 35, 2010 => 53.5, 2011 => 74}, 71, "Mexico", ["Telmex", "América Móvil", "Grupo Carso"]
gates = Rich.new "Gates", {2009 => 40, 2010 => 53, 2011 => 56}, 56, "U.S.", ["Microsoft"]
mittal = Rich.new "Mittal", {2009 => 19.3, 2010 => 28.7, 2011 => 31}, 60, "India", ["Arcelor Mittal"]
eike = Rich.new "Eike", {2009 => 0, 2010 => 27, 2011 => 30}, 53, "Brasil", ["EBX Group"]

puts gates.rank 2009
puts gates.rank 2010

puts Rich.est(2009).inspect
puts Rich.rank(2010).inspect

puts Rich.older.inspect
puts Rich.younger.inspect

puts gates.forecast 2011