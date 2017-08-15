require 'rails_helper'

RSpec.describe 'Occupations API', type: :request do
  # initialize test data
  let!(:occupations) { create_list(:occupation, 5) }
  let(:occupation_id) { occupations.first.id }

  subject { occupations }

  before :each do
    stub_access_token
  end

  # Test suite for GET /occupations
  describe 'GET /occupations' do
    before { get '/occupations' }

    it 'returns occupations' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /occupations/:id
  describe 'GET /occupations/:id' do
    before { get "/occupations/#{occupation_id}" }

    context 'when the record exists' do
      it 'returns the occupation' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(occupation_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:occupation_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Occupation/)
      end
    end
  end

end
