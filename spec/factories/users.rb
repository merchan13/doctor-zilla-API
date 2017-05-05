FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password 'qwerty123'
    password_confirmation 'qwerty123'
    document { "V-#{Faker::Number.number(10)}" }
    name { Faker::Name.first_name + ' ' + Faker::Name.first_name }
    lastname { Faker::Name.last_name + ' ' + Faker::Name.last_name }
    phone { Faker::PhoneNumber.cell_phone }
    role 'Doctor'
    auth_token 'uniquetoken123'
  end
end
