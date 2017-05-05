require 'rails_helper'

RSpec.describe MedicalRecord, type: :model do
  # Association test
  # ensure MedicalRecord model has a n:m relationship with a model
  it { should have_many(:users).through(:user_medical_records) }
  # ensure MedicalRecord model has a 1:m relationship a model
  it { should have_many(:user_medical_records) }
  it { should have_many(:consultations) }
  it { should have_many(:prescriptions) }
  it { should have_many(:attachments) }

  it { should belong_to(:insurance) }
  it { should belong_to(:occupation) }

  # Validation tests
  let(:record) { FactoryGirl.create(:medical_record ) }

  subject { record }

  it { should respond_to(:document) }
  it { should respond_to(:document_type) }
  it { should respond_to(:first_consultation_date) }
  it { should respond_to(:name) }
  it { should respond_to(:last_name) }
  it { should respond_to(:birthday) }
  it { should respond_to(:gender) }
  it { should respond_to(:phone_number) }
  it { should respond_to(:cellphone_number) }
  it { should respond_to(:address) }
  it { should respond_to(:email) }
  it { should respond_to(:referred_by) }
  it { should respond_to(:profile_picture) }
  it { should respond_to(:representative_document) }

  it { should validate_presence_of(:document) }
  it { should validate_presence_of(:document_type) }
  it { should validate_presence_of(:first_consultation_date) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:birthday) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:address) }

  it { should allow_value('23666555').for(:document) }
  it { should allow_value('V').for(:document_type) }
  it { should allow_value('2016/12/31').for(:first_consultation_date) }
  it { should allow_value('Javier Alonso').for(:name) }
  it { should allow_value('Doe Wick').for(:last_name) }
  it { should allow_value('2016/12/31').for(:birthday) }
  it { should allow_value('Masculino').for(:gender) }
  it { should allow_value('+582125555555').for(:phone_number) }
  it { should allow_value('+584145555555').for(:cellphone_number) }
  it { should allow_value('Avenida principal de la Lagunita, Urbanizacion Los Cedros, Quinta Topo').for(:address) }
  it { should allow_value('johndoe@example.com').for(:email) }
  it { should allow_value('John Wick').for(:referred_by) }
  it { should allow_value('profile_picture01.jpg').for(:profile_picture) }
  it { should allow_value('V-9555555').for(:representative_document) }

  it { should be_valid }

  # Methods tests
  describe 'full_name' do
    it "returns record pacient's full name" do
      expect(record.full_name).to eq('Javier Alonso Merchan Salazar')
    end
  end

  describe 'full_id' do
    it "returns record pacient's full id" do
      expect(record.full_id).to eq('V-23686197')
    end
  end

  describe 'age' do
    it "returns record pacient's age" do
      expect(record.age).to eq(21)
    end
  end

  describe 'backgrounds' do
    it "returns all the backgrounds"
  end

  describe 'physic_data' do
    it "returns all the physic data"
  end

  describe 'imc' do
    it "returns imc from the latest data"
  end

  describe 'self.search' do
    it "returns search results"
  end

  describe 'self.name_matches' do
    it "returns records that matches a name"
  end

  describe 'self.last_name_matches' do
    it "returns records that matches a lastname"
  end

  describe 'self.document_matches' do
    it "returns records that matches a document"
  end

  describe 'self.matches' do
      it "returns record that matches a param"
  end

end
