require 'rails_helper'

RSpec.describe OperativeNote, type: :model do
  # Association test
  it { should belong_to(:plan) }

  # Validation tests
  let(:operative_note) { FactoryGirl.create(:operative_note) }

  subject { operative_note }

  it { should respond_to(:description) }
  it { should respond_to(:find) }
  it { should respond_to(:diagnostic) }

  it { should validate_presence_of(:description) }

  it { should allow_value('Descripcion de la nota operatoria').for(:description) }
  it { should allow_value('Hallazgo de la nota operatoria').for(:find) }
  it { should allow_value('Diagnostico de la nota operatoria').for(:diagnostic) }

  it { should be_valid(operative_note) }

end
