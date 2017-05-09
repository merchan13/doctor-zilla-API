require 'rails_helper'

RSpec.describe 'Attachments API', type: :request do
  # initialize test data
  let!(:attachment) { create(:attachment) }
  let!(:attachment_id) { attachment.id }

  let!(:attachment_2) { create(:attachment, medical_record: attachment.medical_record) }
  let!(:attachment_3) { create(:attachment, medical_record: attachment.medical_record) }

  before :each do
    stub_access_token
  end

  # Test suite for GET /attachments
  describe 'GET /attachments' do
    # make HTTP get request before each example
    before { get '/attachments', params: { medical_record: attachment.medical_record.id } }

    it 'returns attachments' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /attachments/:id' do
    before { get "/attachments/#{attachment_id}" }

    context 'when the record exists' do
      it 'returns the attachment' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(attachment_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:attachment_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Attachment/)
      end
    end
  end

end
