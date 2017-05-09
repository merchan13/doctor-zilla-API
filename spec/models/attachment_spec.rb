require 'rails_helper'

RSpec.describe Attachment, type: :model do
  # Association test
  it { should belong_to(:medical_record) }

  # Validation tests
  let(:attachment) { FactoryGirl.create(:attachment) }

  subject { attachment }

  it { should respond_to(:description) }
  it { should respond_to(:url) }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:medical_record_id) }

  it { should allow_value('Description').for(:description) }

  it { should be_valid(attachment) }

end
