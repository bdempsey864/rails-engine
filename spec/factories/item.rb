FactoryBot.define do
  factory :item do
    name { Faker::Beer.name }
    description { Faker::TvShows::Seinfeld.quote }
    unit_price { Faker::Number.decimal(l_digits: 2) }
  end
end