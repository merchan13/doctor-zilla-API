require 'rails_helper'

RSpec.describe 'Plans API', type: :request do
  # initialize test data
  let!(:plan) { create(:plan) }
  let!(:plan_id) { plan.id }

  before :each do
    stub_access_token
  end

  # Test suite for GET /users/:id
  describe 'GET /plans/:id' do
    before { get "/plans/#{plan_id}" }

    context 'when the record exists' do
      it 'returns the medical plan' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(plan_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:plan_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Plan/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /plans/:id' do
    let(:valid_attributes) { { plan: { description: 'Updated description' } } }

    context 'when the record exists' do
      before { put "/plans/#{plan_id}", params: valid_attributes }

      it 'updates the plan' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for GET /procedures/:procedure_id/plans
  describe 'GET /procedures/:procedure_id/plans' do

    before :each do
      FactoryGirl.create_list(:plan, 3)
      FactoryGirl.create(:procedure).plans << Plan.all

      get "/procedures/#{Procedure.last.id}/plans"
    end

    it 'returns plans using a given procedure' do
      expect(json).not_to be_empty
      expect(json.size).to eq(4)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
