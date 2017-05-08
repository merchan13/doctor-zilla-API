require 'rails_helper'

RSpec.describe 'Medicines API', type: :request do
  # initialize test data
  let!(:medicines) { create_list(:medicine, 3) }
  let!(:medicine_id) { medicines.first.id }

  before :each do
    stub_access_token
  end

  # Test suite for GET /medicines
  describe 'GET /medicines' do
    # make HTTP get request before each example
    before { get '/medicines' }

    it 'returns medicines' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /medicines/:id' do
    before { get "/medicines/#{medicine_id}" }

    context 'when the record exists' do
      it 'returns the medicine' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(medicine_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:medicine_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Medicine/)
      end
    end
  end

  # Test suite for GET /prescriptions/:prescription_id/medicines
  describe 'GET /prescriptions/:prescription_id/medicines' do

    before :each do
      FactoryGirl.create_list(:medicine, 3)
      FactoryGirl.create(:prescription)
      FactoryGirl.create_list(:prescription_medicine, 6, prescription: Prescription.last)

      get "/prescriptions/#{Prescription.last.id}/medicines"
    end

    it 'returns medicines in a given prescription' do
      expect(json).not_to be_empty
      expect(json.size).to eq(6)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
