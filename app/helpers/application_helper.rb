module ApplicationHelper
	def to_dollars(credits)
		(credits / 450) + 1
	end
end
