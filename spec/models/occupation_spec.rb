require 'rails_helper'

RSpec.describe Occupation, type: :model do
  # Association test
  it { should have_many(:medical_records) }

  # Validation tests
  let(:occupation) { FactoryGirl.build(:occupation) }

  subject { occupation }

  it { should respond_to(:name) }

  it { should validate_presence_of(:name) }

  it { should validate_uniqueness_of(:name) }

end
