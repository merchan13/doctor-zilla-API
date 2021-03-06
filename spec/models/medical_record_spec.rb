require 'rails_helper'

RSpec.describe MedicalRecord, type: :model do
  # Association test
  it { should have_many(:backgrounds) }
  it { should have_many(:consultations) }
  it { should have_many(:attachments) }
  it { should have_many(:reports) }

  it { should belong_to(:user) }
  it { should belong_to(:insurance) }
  it { should belong_to(:occupation) }

  # Validation tests
  let(:record)      { FactoryGirl.create(:medical_record) }
  let(:recordId)    { "#{record.document_type}-#{record.document}" }
  let(:occupation)  { record.occupation }
  let(:insurance)   { record.insurance }

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
  it { should respond_to(:old_record_number) }

  it { should validate_presence_of(:document) }
  it { should validate_presence_of(:document_type) }
  it { should validate_presence_of(:first_consultation_date) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:birthday) }
  it { should validate_presence_of(:gender) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:occupation) }
  it { should validate_presence_of(:insurance) }

  it { should validate_uniqueness_of(:document).scoped_to([:document_type, :user_id]).case_insensitive }
  it { should validate_uniqueness_of(:old_record_number).case_insensitive.allow_nil }

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
  it { should allow_value('1').for(:old_record_number) }

  it { should be_valid(record) }

  # Methods tests
  describe 'full_name' do
    it "returns record pacient's full name" do
      expect(record.full_name).to eq('Javier Alonso Merchan Salazar')
    end
  end

  describe 'full_id' do
    it "returns record pacient's full id" do
      expect(record.full_id).to eq(recordId)
    end
  end

  describe 'age' do
    it "returns record pacient's age" do
      expect(record.age).to eq(21)
    end
  end

  # Data set up for specific methods below
  before do
    FactoryGirl.create(:medical_record, document:'1111111111', name:'John', last_name:'Perez', insurance: insurance, occupation: occupation)
    FactoryGirl.create(:medical_record, document:'2222222222', name:'Mary', last_name:'Perez', insurance: insurance, occupation: occupation)
    FactoryGirl.create(:medical_record, document:'3333333333', name:'Jose', last_name:'Perez', insurance: insurance, occupation: occupation)
    FactoryGirl.create(:medical_record, document:'4444444444', name:'Jane', last_name:'Rodriguez', insurance: insurance, occupation: occupation)
    FactoryGirl.create(:consultation, medical_record: MedicalRecord.last, weight: 80, height: 180, pressure_d:'110', pressure_s:'80')
  end

  describe 'physic_data' do
    it "returns all the physic data" do
      expect(MedicalRecord.last.physic_data['weight']).to eq(80)
      expect(MedicalRecord.last.physic_data['height']).to eq(180)
      expect(MedicalRecord.last.physic_data['pressure_d']).to eq('110')
      expect(MedicalRecord.last.physic_data['pressure_s']).to eq('80')
    end
  end

  describe 'imc' do
    it "returns imc from the latest data" do
      expect(MedicalRecord.last.imc.round(2)).to eq(24.69)
    end
  end

  # Class methods
  describe 'search' do
    context "matching results" do
      it "returns search results" do
        expect(MedicalRecord.search('Perez').count).to eq(3)
      end
    end

    context "non-matching results" do
      it "returns zero results" do
        expect(MedicalRecord.search('Zandra').count).to eq(0)
      end
    end
  end

  describe 'name_matches' do
    context "matching results" do
      it "returns search results" do
        expect(MedicalRecord.name_matches('Jo').count).to eq(2)
      end
    end

    context "non-matching results" do
      it "returns zero results" do
        expect(MedicalRecord.name_matches('Zandra').count).to eq(0)
      end
    end
  end

  describe 'last_name_matches' do
    context "matching results" do
      it "returns search results" do
        expect(MedicalRecord.last_name_matches('Perez').count).to eq(3)
      end
    end

    context "non-matching results" do
      it "returns zero results" do
        expect(MedicalRecord.last_name_matches('Gonzalez').count).to eq(0)
      end
    end
  end

  describe 'document_matches' do
    context "matching results" do
      it "returns search results" do
        expect(MedicalRecord.document_matches('1111111111').count).to eq(1)
      end
    end

    context "non-matching results" do
      it "returns zero results" do
        expect(MedicalRecord.document_matches('12345678987654321').count).to eq(0)
      end
    end
  end

  describe 'matches' do
    context "matching results" do
      it "returns search results" do
        expect(MedicalRecord.matches('last_name','Perez').count).to eq(3)
      end
    end

    context "non-matching results" do
      it "returns zero results" do
        expect(MedicalRecord.matches('document','12345678987654321').count).to eq(0)
      end
    end
  end

end
