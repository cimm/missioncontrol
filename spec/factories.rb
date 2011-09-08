require 'factory_girl/syntax/sham'

Sham.executed_at { |n| Date.today + n.days }
Sham.nickname    { |n| "Acme #{n}" }
Sham.name        { |n| "Project #{n}" }
Sham.hours_spent { |n| rand(24)+1 }

FactoryGirl.define do
  factory :unit do
    executed_at
    project
    hours_spent
  end

  factory :client do
    nickname
  end

  factory :project do
    name
    client
  end
end
