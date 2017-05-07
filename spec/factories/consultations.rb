FactoryGirl.define do
  factory :consultation do
    medical_record
    evolution 'Evolucion X'
    note 'Nota X'
    affliction 'Enfermedad X'
    weight 75.00
    height 175.00
    pressure_s '110'
    pressure_d '60'
  end
end
