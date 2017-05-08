require 'rails_helper'

RSpec.describe PrescriptionMedicine, type: :model do
  # Association test
  it { should belong_to(:prescription) }
  it { should belong_to(:medicine) }

  # Validation tests
  let(:prescription_medicine) { FactoryGirl.build(:prescription_medicine) }

  subject { prescription_medicine }

  it { should respond_to(:prescription_id) }
  it { should respond_to(:medicine_id) }
  it { should respond_to(:dose_way) }
  it { should respond_to(:dose_presentation) }
  it { should respond_to(:dose_quantity) }
  it { should respond_to(:dose_unit) }
  it { should respond_to(:interval_quantity) }
  it { should respond_to(:interval_unit) }
  it { should respond_to(:interval_time) }
  it { should respond_to(:duration_quantity) }
  it { should respond_to(:duration_unit) }
  it { should respond_to(:note) }

  it { should validate_presence_of(:prescription_id) }
  it { should validate_presence_of(:medicine_id) }

  it { should allow_value('via de aplicacion').for(:dose_way) }
  it { should allow_value('presentacion').for(:dose_presentation) }
  it { should allow_value(99.99).for(:dose_quantity) }
  it { should allow_value('unidad').for(:dose_unit) }
  it { should allow_value(99.99).for(:interval_quantity) }
  it { should allow_value('unidad').for(:interval_unit) }
  it { should allow_value(99.99).for(:interval_time) }
  it { should allow_value(99.99).for(:duration_quantity) }
  it { should allow_value('unidad').for(:duration_unit) }
  it { should allow_value('nota').for(:note) }

  it { should be_valid(prescription_medicine) }

end
