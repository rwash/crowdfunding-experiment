class Experiment < ActiveRecord::Base 
	has_many :rounds, :dependent => :destroy
  has_many :groups, :through => :rounds
	has_many :users, :dependent => :destroy  
	
	after_create :generate_rounds 
  after_create :generate_users
  after_create :generate_preferences
	
	
	def generate_rounds
		1.upto(TOTAL_NUMBER_OF_ROUNDS) do |i|
      if i <= NUMBER_OF_PRACTICE_ROUNDS
        self.rounds << Round.create(:number => i, :round_type => "PRACTICE")
      else
        self.rounds << Round.create(:number => i, :round_type => "LIVE")            
      end
    end
		self.save!
	end
	
	
	def generate_users     
    @rand_array = (0..(NUMBER_OF_USERS-1)).to_a.sort{ rand() - 0.5 }[0..(NUMBER_OF_CREATORS-1)]
    NUMBER_OF_USERS.times do |i|  
      if @rand_array.include?(i)
        self.users << User.create(:name => "temp", :user_type => "Creator") 
      else
        self.users << User.create(:name => "temp", :user_type => "Donor") 
      end
    end  
		self.save!
	end
	
	                                                            
	def generate_preferences
    @creators = []
    @donors = []
    User.where(:experiment_id => self.id).each_with_index do |user, j|
      if user.user_type == "Creator"
        @creators << user
      elsif user.user_type == "Donor"
        @donors << user             
      end
    end    
    
    self.rounds.each_with_index do |round, i|  
      @round_groups = []
      round.groups.each do |group|
        @round_groups << group
      end        
     
      @random_creator_group = (0..(NUMBER_OF_CREATORS-1)).to_a.sort{ rand() - 0.5 }[0..(NUMBER_OF_CREATORS_PER_GROUP-1)] 
      @creators.each_with_index do |creator, k|
        if @random_creator_group.include?(k)
          creator.creator_preferences << CreatorPreference.create(:group => @round_groups[0], :round => round)            
        else
          creator.creator_preferences << CreatorPreference.create(:group => @round_groups[1], :round => round)           
        end
      end
      
      @random_donor_group = (0..(NUMBER_OF_DONORS-1)).to_a.sort{ rand() - 0.5 }[0..(NUMBER_OF_DONORS_PER_GROUP-1)]   
      @donors.each_with_index do |donor, m|
        if @random_donor_group.include?(m)
          donor.donor_preferences << DonorPreference.create(:group => @round_groups[0], :round => round)            
        else
          donor.donor_preferences << DonorPreference.create(:group => @round_groups[1], :round => round)              
        end        
      end
    end
    self.save!                                  
  end                             
	
	
	def set_current_round(round_number)
    self.current_round_number = round_number
    self.save!
  end
	
	
	def start_experiment
    unless self.started?
      self.started = true
      self.start_time = Time.now
      self.current_round_number = 1
      self.save!
    end
	end

	
	def experiment_over 
    self.users.each do |user|
      @user_total_return = 0
      self.rounds.each do |round|
    		if user.user_type == "Creator"
    		  @preference = CreatorPreference.where(:user_id => user, :round_id => round).first
    		elsif user.user_type == "Donor"
          @preference = DonorPreference.where(:user_id => user, :round_id => round).first
    		end
    		if round.round_type == "LIVE"
          @user_total_return += @preference.total_return if @preference.total_return
        end
      end
      user.total_return = @user_total_return
      user.total_return_in_dollars = (@user_total_return.to_f / CREDITS_TO_DOLLAR_RATE).ceil
      user.save!
    end
    self.finished = true                                        
    self.save!
	end
  
end
