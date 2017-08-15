require 'rails_helper'

RSpec.describe Insurance, type: :model do
  # Association test
  it { should have_many(:medical_records) }

  # Validation tests
  let(:insurance) { FactoryGirl.create(:insurance) }

  subject { insurance }

  it { should respond_to(:name) }

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name).case_insensitive }

  it { should allow_value('Nombre').for(:name) }

  it { should be_valid(insurance) }

end
