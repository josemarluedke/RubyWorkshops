#Encoding: UTF-8
result = rand 100
puts "Digite um valor"

while true
  guess = gets.to_i
  break if guess == result 
  puts guess > result ? "Menor" : "Maior"
end