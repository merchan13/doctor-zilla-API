require 'rails_helper'

RSpec.describe 'Reasons API', type: :request do
  # initialize test data
  let!(:reasons) { create_list(:reason, 3) }
  let(:reason_id) { reasons.first.id }

  subject { reasons }

  before :each do
    stub_access_token
  end

  # Test suite for GET /reasons
  describe 'GET /reasons' do
    before { get '/reasons' }

    it 'returns reasons' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /reasons/:id
  describe 'GET /reasons/:id' do
    before { get "/reasons/#{reason_id}" }

    context 'when the record exists' do
      it 'returns the reason' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(reason_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:reason_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Reason/)
      end
    end
  end

end
