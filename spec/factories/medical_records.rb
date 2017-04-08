FactoryGirl.define do
  factory :medical_record do
    document { Faker::Number.number(10) }
    document_type 'V'
    first_consultation_date '2017/01/01'
    name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    birth_date '1995/05/13'
    gender 'Masculino'
    phone_number { Faker::PhoneNumber.cell_phone }
    cellphone_number { Faker::PhoneNumber.cell_phone }
    address { "#{Faker::Address.city}, #{Faker::Address.street_address}, #{Faker::Address.secondary_address}" }
    email { Faker::Internet.safe_email }
    referred_by { Faker::Name.first_name }
    profile_picture 'perfil.jpg'
    representative_document { "V-#{Faker::Number.number(10)}" }
  end
end
