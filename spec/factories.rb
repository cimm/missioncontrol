require 'factory_girl/syntax/sham'

Sham.executed_at {|n| Date.today + n.days}
Sham.nickname    {|n| "Acme #{n}"}

FactoryGirl.define do
  factory :unit do
    executed_at
  end

  factory :client do
    nickname
  end
end
