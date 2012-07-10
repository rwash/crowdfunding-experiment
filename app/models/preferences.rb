class Preferences < ActiveRecord::Base
	has_one :round
	belongs_to :user
	has_one :number, :through => :round
	
	validates :kind_of, :inclusion => 1..6
	after_create :fill_in_payouts
	
	#saves them and checks if they are the last one ready for the next round
	def ready_save_and_check_summary
		self.finished_and_ready = true
		self.save!
		@round = Round.find(self.round_id)
		@round.prefs.each do |p|
			if !p.finished_and_ready
				return
			end
		end
		
	end
	
	def ready_save_and_check_round
		self.ready_to_start = true
		self.save!
		@round = Round.find(self.round_id)
		@round.prefs.each do |p|
			if !p.ready_to_start
				return
			end
		end
		
		@round.started = true
		@round.save!
	end
	
	def fill_in_payouts
		case self.kind_of
		when 1
			self.a_payout = USER_PAYOUTS[0]
			self.b_payout = USER_PAYOUTS[1]
			self.c_payout = USER_PAYOUTS[2]
			self.d_payout = USER_PAYOUTS[3]
		when 2
			self.d_payout = USER_PAYOUTS[0]
			self.a_payout = USER_PAYOUTS[1]
			self.b_payout = USER_PAYOUTS[2]
			self.c_payout = USER_PAYOUTS[3]
		when 3
			self.c_payout = USER_PAYOUTS[0]
			self.d_payout = USER_PAYOUTS[1]
			self.a_payout = USER_PAYOUTS[2]
			self.b_payout = USER_PAYOUTS[3]
		when 4
			self.b_payout = USER_PAYOUTS[0]
			self.c_payout = USER_PAYOUTS[1]
			self.d_payout = USER_PAYOUTS[2]
			self.a_payout = USER_PAYOUTS[3]
		when 5
			self.a_payout = USER_PAYOUTS[0]
			self.c_payout = USER_PAYOUTS[1]
			self.b_payout = USER_PAYOUTS[2]
			self.d_payout = USER_PAYOUTS[3]
		when 6
			self.d_payout = USER_PAYOUTS[0]
			self.b_payout = USER_PAYOUTS[1]
			self.c_payout = USER_PAYOUTS[2]
			self.a_payout = USER_PAYOUTS[3]
		end
		self.save!
	end
end