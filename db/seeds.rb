conditions = ["Fundable", "Difficult"]
project_names = ["Red", "Yellow", "Blue"]
project_types = { Fundable: ['low','high','fundable'], Difficult: ['low','high','difficult']}
payouts = {
     Fundable: {
        low: [15,15,15,15,15,15],
        high: [45,45,35,25,15,15],
        fundable: [45,35,45,45,35,45]
    },
     Difficult: {
        low: [15,15,15,15,15,15],
        high: [45,45,35,25,15,15],
        difficult: [35,35,25,25,15,15]
    }
}

conditions.each do |condition|
  1.upto(20) do |round|
    1.upto(3) do |i|
      project_type = project_types[condition.to_sym][i-1]
      project_name = project_names[i-1]
      1.upto(6) do |user|
        payout = payouts[condition.to_sym][project_type.to_sym][user-1]
        #puts round, project_type, project_name, user, condition, payout
        Payouts.create(round: round, project_type: project_type, project_name: project_name, user: user, condition_name: condition, payout: payout)
      end
      payouts[condition.to_sym][project_type.to_sym].rotate!
    end
    project_types[condition.to_sym].rotate!
  end
end
