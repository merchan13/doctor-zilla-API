require 'rails_helper'

RSpec.describe Assistantship, type: :model do
  # Association test
  it { should belong_to(:user) }
  it { should belong_to(:assistant).class_name('User') }

  # Validation tests
  let(:assistantship) { FactoryGirl.build(:assistantship) }

  subject { assistantship }

  it { should respond_to(:user_id) }
  it { should respond_to(:assistant_id) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:assistant_id) }

  it { should be_valid(assistantship) }

end
