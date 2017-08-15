FactoryGirl.define do
  factory :insurance do
    name { Faker::ChuckNorris.unique.fact }
  end
end
