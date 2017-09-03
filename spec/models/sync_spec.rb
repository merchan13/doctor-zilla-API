require 'rails_helper'

RSpec.describe Sync, type: :model do
  let!(:sync) { FactoryGirl.create(:sync) }

  subject { sync }

  it { should respond_to(:description) }
  it { should respond_to(:sync_date) }

  it { should validate_presence_of(:sync_date) }

  it { should allow_value('Sync description...').for(:description) }
  it { should allow_value(Time.now).for(:sync_date) }

  it { should be_valid(sync) }

  describe 'medical_records' do
    let(:record) { FactoryGirl.create(:medical_record) }

    it "returns medical records latest data" do
      record.updated_at = Time.now.tomorrow
      record.save

      expect(Sync.medical_records).not_to be_empty
      expect(Sync.medical_records.size).to eq(1)
    end
  end

  describe 'consultations' do
    let(:consultation) { FactoryGirl.create(:consultation) }

    it "returns consultations latest data" do
      consultation.updated_at = Time.now.tomorrow
      consultation.save

      expect(Sync.consultations).not_to be_empty
      expect(Sync.consultations.size).to eq(1)
    end
  end

end
