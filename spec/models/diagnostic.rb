require 'rails_helper'

RSpec.describe Diagnostic, type: :model do
  # Association test
  it { should have_many(:consultations) }

  # Validation tests
  let(:diagnostic) { FactoryGirl.build(:diagnostic) }

  subject { diagnostic }

  it { should respond_to(:description) }

  it { should validate_presence_of(:description) }

  it { should allow_value('Descripcion').for(:description) }

  it { should be_valid(:diagnostic) }

end
