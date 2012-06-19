module RoundsHelper
	def last_round?(round)
		round == round.experiment.rounds.last
	end
end
