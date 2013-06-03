class Experiment < ActiveRecord::Base

	#has_many :rounds, :dependent => :destroy
	has_many :groups, :dependent => :destroy
	has_many :users, :dependent => :destroy
	has_many :rounds, :through => :groups
	# has_one :admin
	
	after_create :generate_groups
	after_create :generate_users
  after_create :set_current_round_and_generate_prefs
  # after_create :mgaic_preferences                   <REMOVE CL>
	
	
	def generate_groups
		reseed_names
		self.groups << Group.create(:name => 'A')
		reseed_names
		self.groups << Group.create(:name => 'B')
		self.save!
	end


	def generate_users
    @group_ids = Group.all(:select => :id).collect(&:id)
    NUMBER_OF_GROUPS.times do |i|
	    @rand_array = (0..(NUMBER_OF_USERS_PER_GROUP-1)).to_a.sort{ rand() - 0.5 }[0..(NUMBER_OF_CREATORS_PER_GROUP-1)]
  		NUMBER_OF_USERS_PER_GROUP.times do |j|
  		  if @rand_array.include?(j)
  			  self.users << User.create(:name => "temp", :user_type => "Creator", :group_id => @group_ids[i])
  			else
  			  self.users << User.create(:name => "temp", :user_type => "Donor", :group_id => @group_ids[i])
  			end
  		end
	  end
		self.save!
	end
	
	
	def set_current_round_and_generate_prefs
    self.groups.each do |g|               # <REMOVE CL>  This is no longer required.  Also remove method in Group Model.
      g.generate_prefs                    # <REMOVE CL>
    end                                   # <REMOVE CL>
    
		self.current_round_number = 1
		self.save!
	end
	
	
	def start_experiment
		self.started = true
		self.save!
	end
	
	
	def set_current_round(round)
	  if self.current_round_number != round.number
  	  self.current_round_number = round.number
  	  self.save!
  	end
	end
	
	
	def experiment_over
		self.users.each do |user|
			user.payout = 0
			@preferences = Preferences.where(:user_id => user.id)
			@preferences.each do |pref|
				user.payout += pref.round_payout
			end
			user.save!
		end
	
		self.finsihed_calc = true
		self.save!
	end
	
	
	def reseed_names
			require 'csv'
			$project_names = []
			CSV.foreach("colors4.csv", :headers => false) do |row|
			  $project_names << row[0]
			end
			
			$project_names.each do |n|
				n.gsub!(";",'')
			end
	end
	
	
	def mgaic_preferences                     # <REMOVE CL> Replace with new Preference Allocation
		self.users.each_with_index do |u, i|
			NUMBER_OF_ROUNDS.times do |r|
				if i < 6 #first 6 people
				
					# pick a random group
					@rand = rand(0...2)
					@group = nil
					
					case @rand
					when 1
						@group = self.groups[0] #.first
					when 0
						@group = self.groups[1] #.last
					end
					
					# put them in that group with the correct preferences
					@roundPrefs = @group.rounds.where(:number => r + 1).first.prefs					
					@prefs = @roundPrefs.where(:kind_of => ((r + i) % 6) + 1).first
					@prefs.user_id = u.id
					@prefs.save!
					
					u.group_id = @group.id
					u.save!
				else #last 6 people
					
					# Is there already a user in the first group with the preferences I need? If not, put them in that group, if so put them in the other group.
					if self.groups.first.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first.user_id.nil?
						@prefs = self.groups.first.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first
						@prefs.user_id = u.id
						@prefs.save!
						
						u.group_id = self.groups.first.id
						u.save!
					elsif self.groups.last.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first.user_id.nil?
						@prefs = self.groups.last.rounds.where(:number => r + 1).first.prefs.where(:kind_of => ((r + i) % 6) + 1).first
						@prefs.user_id = u.id
						@prefs.save!
						
						u.group_id = self.groups.last.id
						u.save!
					else
						# this will cause the thing to explode and give you an error during db:seed telling you somthing is wrong
						qq = xx
					end

				end
			end
		end
	end
end
