module ApplicationHelper
  
	def convert_credits_to_dollars(credits)
		@dollars = (credits / CREDITS_TO_DOLLAR_RATE) + 1     # <TODO CL> Check conversion
		return @dollars
	end
	
end
