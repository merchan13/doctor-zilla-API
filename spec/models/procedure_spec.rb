require 'rails_helper'

RSpec.describe Procedure, type: :model do
  # Association test
  it { should have_many(:plans) }
  it { should have_many(:plans).through(:plan_procedures) }

  # Validation tests
  let(:procedure) { FactoryGirl.build(:procedure) }

  subject { procedure }

  it { should respond_to(:name) }
  it { should respond_to(:description) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }

  it { should allow_value('Nombre').for(:name) }
  it { should allow_value('Descripcion').for(:description) }

  it { should be_valid(procedure) }

end
