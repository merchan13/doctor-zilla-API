require 'rails_helper'

RSpec.describe PlanProcedure, type: :model do
  # Association test
  it { should belong_to(:plan) }
  it { should belong_to(:procedure) }

  # Validation tests
  let(:plan_procedure) { FactoryGirl.build(:plan_procedure) }

  subject { plan_procedure }

  it { should respond_to(:plan_id) }
  it { should respond_to(:procedure_id) }

  it { should validate_presence_of(:plan_id) }
  it { should validate_presence_of(:procedure_id) }

  it { should be_valid(plan_procedure) }

end
