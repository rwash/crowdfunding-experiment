module RoundsHelper
	def last_round?(round)
		round == round.group.rounds.last
	end
end
