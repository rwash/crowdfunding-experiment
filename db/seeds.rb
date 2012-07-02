@user = User.create(:name => 'admin', :password => 'password')

# pilot tests
puts 'pilot'
2.times do |i|
	puts i
	@experiment = Experiment.create(:return_credits => true)
end

1.times do
	puts '3'
	@experiment = Experiment.create(:return_credits => false)
end

# real tests
puts 'real'
10.times do |i|
	puts i
	if i%2 == 0
		@experiment = Experiment.create(:return_credits => true)
	else
		@experiment = Experiment.create(:return_credits => false)
	end
end