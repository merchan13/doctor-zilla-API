require 'rails_helper'

RSpec.describe Medicine, type: :model do
  # Association test
  it { should have_many(:prescription_medicines) }
  it { should have_many(:prescriptions).through(:prescription_medicines) }

  # Validation tests
  let(:medicine) { FactoryGirl.build(:medicine) }

  subject { medicine }

  it { should respond_to(:generic_name) }
  it { should respond_to(:comercial_name) }

  it { should validate_presence_of(:generic_name) }

  it { should allow_value('Generico').for(:generic_name) }
  it { should allow_value('Comercial').for(:comercial_name) }

  it { should be_valid(medicine) }

end
