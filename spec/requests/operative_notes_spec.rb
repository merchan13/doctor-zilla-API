require 'rails_helper'

RSpec.describe 'Operative Note API', type: :request do
  # initialize test data
  let!(:operative_note) { create(:operative_note) }
  let!(:operative_note_id) { operative_note.id }

  before :each do
    stub_access_token
  end

  # Test suite for GET /users/:id
  describe 'GET /operative_notes/:id' do
    before { get "/operative_notes/#{operative_note_id}" }

    context 'when the record exists' do
      it 'returns the medical operative_note' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(operative_note_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:operative_note_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find OperativeNote/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /operative_notes/:id' do
    let(:valid_attributes) { { operative_note: { description: 'Updated description' } } }

    context 'when the record exists' do
      before { put "/operative_notes/#{operative_note_id}", params: valid_attributes }

      it 'updates the operative_note' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end
