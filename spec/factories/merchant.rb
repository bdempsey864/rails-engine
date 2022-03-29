FactoryBot.define do
  factory :merchant do
    name { Faker::Beer.brand }
  end
end