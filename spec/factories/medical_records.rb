FactoryGirl.define do
  factory :medical_record do
    document { "#{Faker::Number.number(10)}" }
    document_type 'V'
    first_consultation_date '2017/01/01'
    name { 'Javier Alonso' }
    last_name { 'Merchan Salazar' }
    birthday { 21.years.ago }
    gender 'Masculino'
    phone_number { Faker::PhoneNumber.cell_phone }
    cellphone_number { Faker::PhoneNumber.cell_phone }
    address { "#{Faker::Address.city}, #{Faker::Address.street_address}, #{Faker::Address.secondary_address}" }
    email { Faker::Internet.safe_email }
    referred_by { Faker::Name.first_name }
    profile_picture 'perfil.jpg'
    representative_document { "V-#{Faker::Number.number(10)}" }
    old_record_number nil
    occupation
    insurance
    user
  end
end
