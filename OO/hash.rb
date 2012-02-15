class Hash
  #alias :+ :merge
  
  def + other_hash
     self.merge other_hash
   end
 
  def - other_hash
    self.reject{ |k, v| other_hash[k] == v }
  end
  
  def +@
    Hash[self.map{ |k, v| [k.succ, v.succ] }]
  end
end

puts ({a: 1} + {b: 2}).inspect
puts ({a: 1, b: 2} - {b: 2}).inspect
puts (+ {a: 1, c: 3})