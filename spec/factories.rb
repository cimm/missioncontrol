FactoryGirl.define do
  factory :unit do
    executed_at Date.today
  end

  factory :client do
    nickname "Acme" # TODO Use shams for the nickname
  end
end
