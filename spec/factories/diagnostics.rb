FactoryGirl.define do
  factory :diagnostic do
    description { Faker::ChuckNorris.unique.fact }
  end
end
