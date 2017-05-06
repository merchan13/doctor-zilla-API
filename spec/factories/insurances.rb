FactoryGirl.define do
  factory :insurance do
    name { Faker::Beer.unique.name }
  end
end
