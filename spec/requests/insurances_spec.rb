require 'rails_helper'

RSpec.describe 'Insurances API', type: :request do
  # initialize test data
  let!(:insurances) { create_list(:insurance, 5) }
  let(:insurance_id) { insurances.first.id }

  subject { insurances }

  before :each do
    stub_access_token
  end

  # Test suite for GET /insurances
  describe 'GET /insurances' do
    before { get '/insurances' }

    it 'returns insurances' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /insurances/:id
  describe 'GET /insurances/:id' do
    before { get "/insurances/#{insurance_id}" }

    context 'when the record exists' do
      it 'returns the insurance' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(insurance_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:insurance_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Insurance/)
      end
    end
  end

end
