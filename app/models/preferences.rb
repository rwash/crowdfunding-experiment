class Preferences < ActiveRecord::Base
	has_one :round
	has_one :user
	
	validates :kind_of, :inclusion => 1..6
	after_create :fill_in_payouts
	
	def fill_in_payouts
		case self.kind_of
		when 1
			self.a_payout = 200
			self.b_payout = 150
			self.c_payout = 100
			self.d_payout = 50
		when 2
			self.d_payout = 200
			self.a_payout = 150
			self.b_payout = 100
			self.c_payout = 50
		when 3
			self.c_payout = 200
			self.d_payout = 150
			self.a_payout = 100
			self.b_payout = 50
		when 4
			self.b_payout = 200
			self.c_payout = 150
			self.d_payout = 100
			self.a_payout = 50
		when 5
			self.a_payout = 200
			self.c_payout = 150
			self.b_payout = 100
			self.d_payout = 50
		when 6
			self.d_payout = 200
			self.b_payout = 150
			self.c_payout = 100
			self.a_payout = 50
		end
		self.save!
	end
end