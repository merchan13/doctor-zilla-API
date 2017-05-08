FactoryGirl.define do
  factory :prescription_medicine do
    prescription
    medicine
    dose_way { Faker::App.name }
    dose_presentation { Faker::App.author }
    dose_quantity { Faker::Number.decimal(2) }
    dose_unit {'cc'}
    interval_quantity { Faker::Number.decimal(2) }
    interval_unit {'horas'}
    duration_quantity { Faker::Number.decimal(2) }
    duration_unit {'dias'}
    note { Faker::ChuckNorris.fact }
    interval_time { Faker::Number.decimal(2) }
  end
end
