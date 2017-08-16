require "rails_helper"

RSpec.describe "Diagnostics API", type: :request do
  # initialize test data
  let!(:diagnostics) { create_list(:diagnostic, 5) }
  let(:diagnostic_id) { diagnostics.first.id }

  subject { diagnostics }

  before :each do
    stub_access_token
  end

  # Test suite for GET /v1/diagnostics
  describe "GET /v1/diagnostics" do
    before { get "/v1/diagnostics" }

    it "returns diagnostics" do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/diagnostics/:id
  describe "GET /v1/diagnostics/:id" do
    before { get "/v1/diagnostics/#{diagnostic_id}" }

    context "when the record exists" do
      it "returns the diagnostic" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(diagnostic_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:diagnostic_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Diagnostic/)
      end
    end
  end

end
