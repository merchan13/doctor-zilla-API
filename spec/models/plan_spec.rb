require 'rails_helper'

RSpec.describe Plan, type: :model do
  # Association test
  it { should belong_to(:consultation) }

  it { should have_one(:operative_note) }

  it { should have_many(:plan_procedures) }
  it { should have_many(:procedures).through(:plan_procedures) }

  # Validation tests
  let(:plan) { FactoryGirl.create(:plan) }

  subject { plan }

  it { should respond_to(:description) }
  it { should respond_to(:emergency) }

  it { should validate_presence_of(:description) }

  it { should allow_value('Descripcion del plan').for(:description) }
  it { should allow_value(true).for(:emergency) }

  it { should be_valid(plan) }

end
