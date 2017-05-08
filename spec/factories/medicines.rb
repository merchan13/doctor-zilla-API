FactoryGirl.define do
  factory :medicine do
    comercial_name { Faker::Cat.name }
    generic_name { Faker::StarWars.character }
  end
end
