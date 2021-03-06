require 'rails_helper'

RSpec.describe Diagnostic, type: :model do
  # Association test
  it { should have_many(:consultation_diagnostics) }
  it { should have_many(:consultations).through(:consultation_diagnostics) }

  # Validation tests
  let(:diagnostic) { FactoryGirl.create(:diagnostic) }

  subject { diagnostic }

  it { should respond_to(:description) }

  it { should validate_presence_of(:description) }

  it { should validate_uniqueness_of(:description).case_insensitive }

  it { should allow_value('Descripcion').for(:description) }

  it { should be_valid(diagnostic) }

end
