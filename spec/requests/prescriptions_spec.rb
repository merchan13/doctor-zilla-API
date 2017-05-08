require 'rails_helper'

RSpec.describe 'Prescriptions API', type: :request do
  # initialize test data
  let!(:record) { create(:medical_record) }
  let!(:prescriptions) { create_list(:prescription, 3, medical_record: record) }
  let!(:prescription_id) { prescriptions.first.id }

  before :each do
    stub_access_token
  end

  # Test suite for GET /prescriptions
  describe 'GET /prescriptions' do
    # make HTTP get request before each example
    before { get '/prescriptions', params: { record: record.id } }

    it 'returns prescriptions' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /prescriptions/:id' do
    before { get "/prescriptions/#{prescription_id}" }

    context 'when the record exists' do
      it 'returns the prescription' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(prescription_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:prescription_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Prescription/)
      end
    end
  end

  # Test suite for GET /medicines/:medicine_id/prescriptions
  describe 'GET /medicines/:medicine_id/prescriptions' do

    before :each do
      FactoryGirl.create_list(:procedure, 3)
      FactoryGirl.create(:medicine)
      FactoryGirl.create_list(:prescription_medicine, 6, medicine: Medicine.last)

      get "/medicines/#{Medicine.last.id}/prescriptions"
    end

    it 'returns prescriptions using a given medicine' do
      expect(json).not_to be_empty
      expect(json.size).to eq(6)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
