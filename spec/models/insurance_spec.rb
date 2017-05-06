require 'rails_helper'

RSpec.describe Insurance, type: :model do
  # Association test
  it { should have_many(:medical_records) }

  # Validation tests
  let(:insurance) { FactoryGirl.build(:insurance) }

  subject { insurance }

  it { should respond_to(:name) }

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name) }

end
