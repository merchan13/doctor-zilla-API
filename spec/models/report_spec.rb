require 'rails_helper'

RSpec.describe Report, type: :model do
  # Association test
  it { should belong_to(:medical_record) }
  it { should have_many(:attachment_reports) }
  it { should have_many(:attachments).through(:attachment_reports) }

  # Validation tests
  let(:report) { FactoryGirl.create(:report) }

  subject { report }

  it { should respond_to(:report_type) }
  it { should respond_to(:description) }

  it { should validate_presence_of(:description) }

  it { should allow_value('Tipo de Informe').for(:report_type) }
  it { should allow_value('Description').for(:description) }

  it { should be_valid(report) }

end
