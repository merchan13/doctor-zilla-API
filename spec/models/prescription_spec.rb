require 'rails_helper'

RSpec.describe Prescription, type: :model do
  # Association test
  it { should have_many(:prescription_medicines) }
  it { should have_many(:medicines).through(:prescription_medicines) }

  it { should belong_to(:medical_record) }

  # Validation tests
  let(:prescription) { FactoryGirl.create(:prescription) }

  subject { prescription }

  it { should be_valid(prescription) }

end
