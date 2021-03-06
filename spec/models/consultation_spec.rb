require 'rails_helper'

RSpec.describe Consultation, type: :model do
  # Association test
  it { should belong_to(:medical_record) }

  it { should have_many(:physical_exams) }
  it { should have_many(:consultation_diagnostics) }
  it { should have_many(:diagnostics).through(:consultation_diagnostics) }

  it { should belong_to(:reason) }

  it { should have_one(:plan) }

  # Validation tests
  let(:consultation) { FactoryGirl.create(:consultation, weight:70, height:170) }

  subject { consultation }

  it { should respond_to(:evolution) }
  it { should respond_to(:note) }
  it { should respond_to(:affliction) }
  it { should respond_to(:weight) }
  it { should respond_to(:height) }
  it { should respond_to(:pressure_s) }
  it { should respond_to(:pressure_d) }

  it { should allow_value('Evolucion').for(:evolution) }
  it { should allow_value('Nota').for(:note) }
  it { should allow_value('Enfermedad actual').for(:affliction) }
  it { should allow_value(999).for(:height) }
  it { should allow_value(999).for(:weight) }
  it { should allow_value('999').for(:pressure_d) }
  it { should allow_value('999').for(:pressure_s) }

  it { should be_valid(consultation) }

  # Methods tests
  describe 'imc' do
    it "returns IMC calculated with the weight and height" do
      expect(consultation.imc.round(2)).to eq(24.22)
    end
  end
end
