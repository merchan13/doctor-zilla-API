require 'rails_helper'

RSpec.describe PhysicalExam, type: :model do
  # Association test
  it { should belong_to(:consultation) }

  # Validation tests
  let(:physical_exam) { FactoryGirl.create(:physical_exam, exam_type: 'Head and Neck') }

  subject { physical_exam }

  it { should respond_to(:exam_type) }
  it { should respond_to(:url) }
  it { should respond_to(:observation) }

  it { should validate_presence_of(:exam_type) }
  it { should validate_presence_of(:url) }

  it { should allow_value('Tipo de examen').for(:exam_type) }
  it { should allow_value('Url del examen').for(:url) }
  it { should allow_value('Observacion del examen').for(:observation) }

  it { should be_valid(physical_exam) }

  # Methods tests
  describe 'type_es' do
    it "returns the exam type translated to spanish" do
      expect(physical_exam.type_es).to eq('Cabeza y Cuello')
    end
  end
end
