# pilot tests
# puts 'pilot'
# 2.times do |i|
# 	puts i
# 	@experiment = Experiment.create(:return_credits => true)
# end

# 1.times do
# 	puts '2'
# 	@experiment = Experiment.create(:return_credits => false)
# end

# real tests
# puts 'real'
# 10.times do |i|
# 	puts i
# 	if i%2 == 0
# 		@experiment = Experiment.create(:return_credits => true)
# 	else
# 		@experiment = Experiment.create(:return_credits => false)
# 	end
# end

if PayoutCondition.all.size == 0
	cond_one = [
      {"1" => {"red" => 0, "green" => 30, "blue" => 45}}, 
      {"2" => {"red" => 0, "green" => 30, "blue" => 45}}, 
      {"3" => {"red" => 0, "green" => 30, "blue" => 45}}, 
      {"4" => {"red" => 15, "green" => 30, "blue" => 15}}, 
      {"5" => {"red" => 15, "green" => 30, "blue" => 15}}, 
      {"6" => {"red" => 15, "green" => 30, "blue" => 15}}, 
      {"7" => {"red" => 0, "green" => 30, "blue" => 45}}, 
      {"8" => {"red" => 0, "green" => 30, "blue" => 45}}, 
      {"9" => {"red" => 0, "green" => 30, "blue" => 45}}, 
      {"10" => {"red" => 15, "green" => 30, "blue" => 15}}, 
      {"11" => {"red" => 15, "green" => 30, "blue" => 15}}, 
      {"12" => {"red" => 15, "green" => 30, "blue" => 15}}
    ]
	cond_two = [
      {"1" => {"red" => 0, "green" => 30, "blue" => 25}}, 
      {"2" => {"red" => 0, "green" => 30, "blue" => 25}}, 
      {"3" => {"red" => 0, "green" => 30, "blue" => 25}}, 
      {"4" => {"red" => 15, "green" => 30, "blue" => 25}}, 
      {"5" => {"red" => 15, "green" => 30, "blue" => 25}}, 
      {"6" => {"red" => 15, "green" => 30, "blue" => 25}}, 
      {"7" => {"red" => 0, "green" => 30, "blue" => 25}}, 
      {"8" => {"red" => 0, "green" => 30, "blue" => 25}}, 
      {"9" => {"red" => 0, "green" => 30, "blue" => 25}}, 
      {"10" => {"red" => 15, "green" => 30, "blue" => 25}}, 
      {"11" => {"red" => 15, "green" => 30, "blue" => 25}}, 
      {"12" => {"red" => 15, "green" => 30, "blue" => 25}}
    ]
	PayoutCondition.create!({name: "Condition 1", data: cond_one})
	PayoutCondition.create!({name: "Condition 2", data: cond_two})
end