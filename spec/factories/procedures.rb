FactoryGirl.define do
  factory :procedure do
    name { Faker::Cat.name }
    description { Faker::ChuckNorris.fact }
  end
end
