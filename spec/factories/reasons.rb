FactoryGirl.define do
  factory :reason do
    description { Faker::ChuckNorris.unique.fact }
  end
end
