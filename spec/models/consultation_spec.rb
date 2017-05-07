require 'rails_helper'

RSpec.describe Consultation, type: :model do
  # Association test
  # ensure Consultation model has a n:m relationship with a model
  # ...
  # ensure Consultation model has a 1:m relationship a model
  it { should have_many(:backgrounds) }
  it { should have_many(:physical_exams) }

  it { should belong_to(:medical_record) }
  it { should belong_to(:reason) }
  it { should belong_to(:diagnostic) }

  it { should have_one(:plan) }

  # Validation tests
  let(:consultation) { FactoryGirl.create(:consultation, weight:70, height:170) }

  subject { consultation }

  it { should respond_to(:evolution) }

  it { should allow_value('Evolucion').for(:evolution) }
  it { should allow_value('Nota').for(:note) }
  it { should allow_value('Enfermedad actual').for(:affliction) }
  it { should allow_value(999).for(:height) }
  it { should allow_value(999).for(:weight) }
  it { should allow_value('999').for(:pressure_d) }
  it { should allow_value('999').for(:pressure_s) }

  it { should be_valid(:consultation) }

  # Methods tests
  describe 'imc' do
    it "returns IMC calculated with the weight and height" do
      expect(consultation.imc.round(2)).to eq(24.22)
    end
  end
end
