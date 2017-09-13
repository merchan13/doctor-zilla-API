require 'rails_helper'

RSpec.describe ConsultationDiagnostic, type: :model do
  # Association test
  it { should belong_to(:consultation) }
  it { should belong_to(:diagnostic) }

  # Validation tests
  let(:consultation_diagnostic) { FactoryGirl.build(:consultation_diagnostic) }

  subject { consultation_diagnostic }

  it { should respond_to(:consultation_id) }
  it { should respond_to(:diagnostic_id) }

  it { should validate_presence_of(:consultation_id) }
  it { should validate_presence_of(:diagnostic_id) }

  it { should be_valid(consultation_diagnostic) }

end
