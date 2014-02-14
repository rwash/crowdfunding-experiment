class PayoutCondition < ActiveRecord::Base
  serialize :data
  has_many :experiments
end
