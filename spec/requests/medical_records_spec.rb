require 'rails_helper'

RSpec.describe 'Medical Records API', type: :request do
  # initialize test data
  let!(:user) { create(:user) }
  let!(:records) { create_list(:medical_record, 10) }
  let(:medical_record_id) { records.first.id }

  before :each do
    stub_access_token
    stub_current_user(user)
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
    let(:valid_attributes) { { medical_record: { name: 'Dick' } } }

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

  # Test suite for DELETE /users/:id
  describe 'DELETE /medical_records/:id' do
    before { delete "/medical_records/#{medical_record_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end
