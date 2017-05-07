require 'rails_helper'

RSpec.describe 'Consultations API', type: :request do
  # initialize test data
  let!(:consultation) { create(:consultation) }
  let!(:consultation_id) { consultation.id }

  let!(:consultation_2) { create(:consultation, medical_record: consultation.medical_record) }
  let!(:consultation_3) { create(:consultation, medical_record: consultation.medical_record) }

  before :each do
    stub_access_token
  end

  # Test suite for GET /consultations
  describe 'GET /consultations' do
    # make HTTP get request before each example
    before { get '/consultations', params: { record: consultation.medical_record.id } }

    it 'returns medical consultations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /consultations/:id' do
    before { get "/consultations/#{consultation_id}" }

    context 'when the record exists' do
      it 'returns the medical consultation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(consultation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:consultation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Consultation/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /consultations/:id' do
    let(:valid_attributes) { { consultation: { evolution: 'New evolution' } } }

    context 'when the record exists' do
      before { put "/consultations/#{consultation_id}", params: valid_attributes }

      it 'updates the consultation' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end
