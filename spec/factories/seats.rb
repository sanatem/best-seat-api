FactoryBot.define do
  factory :seat do
    row    { (1..27).to_a.sample }
    column { (1..50).to_a.sample }
    association :venue, factory: :venue, strategy: :build
  end
end
