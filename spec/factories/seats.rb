FactoryBot.define do
  factory :seat do
    row  {[1..27].sample }
    column  { [1..50].sample }
    association :venue, factory: :venue, strategy: :build
  end
end
