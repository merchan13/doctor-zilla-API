require "rails_helper"

RSpec.describe "Procedures API", type: :request do
  # initialize test data
  let!(:procedures) { create_list(:procedure, 3) }
  let(:procedure_id) { procedures.first.id }

  subject { procedures }

  before :each do
    stub_access_token
  end

  # Test suite for GET /v1/procedures
  describe "GET /v1/procedures" do
    before { get "/v1/procedures" }

    it "returns procedures" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/procedures/:id
  describe "GET /v1/procedures/:id" do
    before { get "/v1/procedures/#{procedure_id}" }

    context "when the record exists" do
      it "returns the procedure" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(procedure_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:procedure_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Procedure/)
      end
    end
  end

  # Test suite for GET /v1/plans/:plan_id/procedures
  describe "GET /v1/plans/:plan_id/procedures" do

    before :each do
      FactoryGirl.create(:plan)
      Plan.last.procedures << procedures

      get "/v1/plans/#{Plan.last.id}/procedures"
    end

    it "returns procedures used in a procedure" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

end
