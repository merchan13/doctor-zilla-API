require 'rails_helper'

RSpec.describe Background, type: :model do
  # Association test
  it { should belong_to(:medical_record) }

  # Validation tests
  let(:background) { FactoryGirl.create(:background, background_type: 'family') }

  subject { background }

  it { should respond_to(:background_type) }
  it { should respond_to(:description) }

  it { should validate_presence_of(:background_type) }
  it { should validate_presence_of(:description) }

  it { should allow_value('Familiares').for(:background_type) }
  it { should allow_value('Descripcion del antecedente').for(:description) }

  it { should be_valid(background) }

  # Methods tests
  describe 'type_es' do
    it "returns the background type translated to spanish" do
      expect(background.type_es).to eq('Familiares')
    end
  end
end
