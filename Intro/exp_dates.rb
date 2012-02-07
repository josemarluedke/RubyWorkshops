# Encoding: UTF-8
puts "Digite uma data no formato Japonês. (Ex: 2012-02-01)"
date = gets.chomp
exp = /^(\d{4})[-\/](\d{2})[-\/](\d{2})$/

if date.match exp
  puts "Data no formato brasileiro: #{date.gsub exp, '\3/\2/\1'}"
else
  puts "Data no formato inválido."
end