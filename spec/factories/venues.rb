FactoryBot.define do
  factory :venue do
    rows  { (1..27).to_a.sample }
    columns { (1..50).to_a.sample }
  end
end
