module ApplicationHelper
	def to_dollars(credits)
		(credits / CREDITS_TO_DOLLAR) + 1
	end
end
