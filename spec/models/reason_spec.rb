require 'rails_helper'

RSpec.describe Reason, type: :model do
  # Association test
  it { should have_many(:consultations) }

  # Validation tests
  let(:reason) { FactoryGirl.build(:reason) }

  subject { reason }

  it { should respond_to(:description) }

  it { should validate_presence_of(:description) }

  it { should validate_uniqueness_of(:description).case_insensitive }

  it { should allow_value('Descripcion').for(:description) }

  it { should be_valid(reason) }

end
