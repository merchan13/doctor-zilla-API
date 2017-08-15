FactoryGirl.define do
  factory :occupation do
    name { Faker::ChuckNorris.unique.fact }
  end
end
