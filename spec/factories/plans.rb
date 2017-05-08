FactoryGirl.define do
  factory :plan do
    consultation
    description { Faker::StarWars.quote }
    emergency false
  end
end
