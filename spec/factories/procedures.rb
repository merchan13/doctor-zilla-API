FactoryGirl.define do
  factory :procedure do
    name { Faker::Name.unique.name }
    description { Faker::ChuckNorris.fact }
  end
end
