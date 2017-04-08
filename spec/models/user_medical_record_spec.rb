require 'rails_helper'

RSpec.describe UserMedicalRecord, type: :model do
  # Association test
  # ensure UserMedicalRecord model has a n:1 relationship with the User model
  it { should belong_to(:user) }
  # ensure UserMedicalRecord model has a n:1 relationship with the MedicalRecord model
  it { should belong_to(:medical_record) }

  # Validation tests
  let(:user_record) { FactoryGirl.build(:user_medical_record) }

  subject { user_record }

  it { should respond_to(:user_id) }
  it { should respond_to(:medical_record_id) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:medical_record_id) }

end
