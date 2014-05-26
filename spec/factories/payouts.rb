# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payout, :class => 'Payouts' do
    round 1
    project_type "MyString"
    project_name "MyString"
    user 1
    condition 1
    payout 1
  end
end
