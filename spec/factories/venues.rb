FactoryBot.define do
  factory :venue do
    rows  { [1..27].sample }
    columns { [1..50].sample }
  end
end
