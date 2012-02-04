def my_times times, &block
  for i in 1..times
    block.call
  end
end