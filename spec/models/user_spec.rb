require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test
  it { should have_many(:medical_records) }

  # Validation tests
  let(:user) { FactoryGirl.create(:user, name: 'Javier Alonso', lastname: 'Merchan Salazar') }

  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:document) }
  it { should respond_to(:name) }
  it { should respond_to(:lastname) }
  it { should respond_to(:phone) }
  it { should respond_to(:role) }
  it { should respond_to(:auth_token) }

  it { should validate_confirmation_of(:password) }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:document) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:role) }

  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:document) }

  it { should allow_value('example@domain.com').for(:email) }
  it { should allow_value('V-5555555555').for(:document) }
  it { should allow_value('Javier Alonso').for(:name) }
  it { should allow_value('Merchan Salazar ').for(:lastname) }
  it { should allow_value('58 212 5555555').for(:phone) }
  it { should allow_value('Doctor').for(:role) }

  it { should be_valid(user) }

  # Methods tests
  describe 'full_name' do
    it "returns user's full name" do
      expect(user.full_name).to eq('Javier Merchan Salazar')
    end
  end

  describe 'generate_auth_token' do
    it "returns new heaxadecimal token" do
      token = user.generate_auth_token
      expect(user.auth_token).to eq(token)
    end
  end

  describe 'invalidate_auth_token' do
    it "'nullify' token column" do
      user.invalidate_auth_token
      expect(user.auth_token).to eq(nil)
    end
  end

end
