FactoryGirl.define do
  factory :occupation do
    name { Faker::Job.unique.title }
  end
end
