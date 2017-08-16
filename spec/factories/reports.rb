FactoryGirl.define do
  factory :report do
    medical_record
    report_type { "General" }
    description { Faker::ChuckNorris.fact }
  end
end
