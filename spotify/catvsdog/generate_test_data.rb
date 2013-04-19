cat_count = 100
dog_count = 100
votes = 500
data_sets = 500

cats = Range.new(1,cat_count).entries.collect{|c| "C%s" % c}
dogs = Range.new(1,dog_count).entries.collect{|d| "D%s" % d}

puts data_sets

1.upto(data_sets) do |set|
  puts "%s %s %s" % [cat_count, dog_count, votes]
  1.upto(votes) do |vote|
    if rand(2) == 0
      puts "%s %s" % [cats.shuffle[0], dogs.shuffle[0]]
    else
      puts "%s %s" % [dogs.shuffle[0], cats.shuffle[0]]
    end
  end
end
