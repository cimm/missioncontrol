require 'factory_girl/syntax/sham'

Sham.executed_at {|n| Date.today + n.days}
Sham.nickname    {|n| "Acme #{n}"}
Sham.name        {|n| "Project #{n}"}

FactoryGirl.define do
  factory :unit do
    executed_at
    client
  end

  factory :client do
    nickname
  end

  factory :project do
    name
    client
  end
end
