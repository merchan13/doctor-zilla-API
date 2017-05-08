FactoryGirl.define do
  factory :physical_exam do
    consultation
    exam_type 'Head and Neck'
    url 'unknown.png'
    observation { Faker::Lorem.sentence }
  end
end
