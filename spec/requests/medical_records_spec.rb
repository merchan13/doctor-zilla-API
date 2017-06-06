require 'rails_helper'

RSpec.describe 'Medical Records API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:records) { create_list(:medical_record, 10) }
  let(:medical_record_id) { records.first.id }

  before :each do
    stub_access_token
    stub_current_user(user)
    user.medical_records << records
  end

  # Test suite for GET /medical_records
  describe 'GET /medical_records' do
    # make HTTP get request before each example
    before { get '/medical_records' }

    it 'returns medical records' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /medical_records/:id' do
    before { get "/medical_records/#{medical_record_id}" }

    context 'when the record exists' do
      it 'returns the medical record' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(medical_record_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:medical_record_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find MedicalRecord/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /medical_records/:id' do
    let(:valid_attributes) { { medical_record: { name: 'Dick', birthday: '1999/12/12' } } }

    context 'when the record exists' do
      before { put "/medical_records/#{medical_record_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for GET /search_records
  describe 'GET /search_records' do
    before :each do
      FactoryGirl.create(:medical_record, document:'11', name:'John', last_name:'Perez')
      FactoryGirl.create(:medical_record, document:'12', name:'Mary', last_name:'Perez')
      FactoryGirl.create(:medical_record, document:'13', name:'Jose', last_name:'Perez')
      FactoryGirl.create(:medical_record, document:'33', name:'Jane', last_name:'Rodriguez')

      user.medical_records << MedicalRecord.all
    end

    context "when the search is successful" do
      before { get "/search_records", params: { search_param: 'Perez' } }
      it 'returns the medical records' do
        expect(json).not_to be_empty
        expect(json.size).to eq(3)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context "when the search param doesn't match" do
      before { get "/search_records", params: { search_param: 'Zandra' } }

      it 'returns zero records' do
        expect(json).to be_empty
      end
    end

  end

end
