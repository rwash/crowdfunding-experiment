@user = User.create(:name => 'admin', :password => 'password')

# pilot tests
2.times do
	@experiment = Experiment.create(:return_credits => true)
end

1.times do
	@experiment = Experiment.create(:return_credits => false)
end

# real tests
10.times do |i|
	puts i
	if i%2 == 0
		@experiment = Experiment.create(:return_credits => true)
	else
		@experiment = Experiment.create(:return_credits => false)
	end
end