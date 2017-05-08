require 'rails_helper'

RSpec.describe 'Procedures API', type: :request do
  # initialize test data
  let!(:procedures) { create_list(:procedure, 5) }
  let(:procedure_id) { procedures.first.id }

  before :each do
    stub_access_token
  end

  # Test suite for GET /procedures
  describe 'GET /procedures' do
    before { get '/procedures' }

    it 'returns procedures' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /procedures/:id
  describe 'GET /procedures/:id' do
    before { get "/procedures/#{procedure_id}" }

    context 'when the record exists' do
      it 'returns the procedure' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(procedure_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:procedure_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Procedure/)
      end
    end
  end

  # Test suite for GET /plans/:plan_id/procedures
  describe 'GET /plans/:plan_id/procedures' do

    before :each do
      FactoryGirl.create(:plan).procedures << Procedure.all

      get "/plans/#{Plan.last.id}/procedures"
    end

    it 'returns procedures used in a procedure' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
