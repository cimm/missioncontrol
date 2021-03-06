require 'factory_girl/syntax/sham'

Sham.executed_at { |n| Date.today + n.days }

Sham.nickname    { |n| "Acme #{n}" }
Sham.vat_number  { |n| "BE 0123.456.78#{n}" }

Sham.name        { |n| "Project #{n}" }
Sham.hours_spent { rand(24)+1 }

Sham.setting     { |n| "preference_#{n}" }

Sham.number      { |n| n+1 }
Sham.owed_at     { |n| Date.today - (n+1).days }
Sham.payed_at    { |n| Date.today - 1.day }

Sham.company     { |n| "Acme #{n}" }
Sham.amount      { rand(200)+1 }
Sham.debit       { [true, false].sample }
Sham.booked_at   { |n| Date.today - 1.day }

FactoryGirl.define do
  factory :unit do
    executed_at
    project
    hours_spent
  end

  factory :client do
    nickname
  end

  factory :client_with_vat_number, :parent => :client do
    vat_number
  end

  factory :project do
    name
    client
  end

  factory :preference do
    setting
  end

  factory :invoice do
    number

    factory :payed_invoice do
      owed_at
      payed_at
    end

    factory :overdue_invoice do
      owed_at
    end
  end

  factory :expense do
    number
    company
    amount
    debit
    booked_at
  end
end
