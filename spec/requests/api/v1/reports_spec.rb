require "rails_helper"

RSpec.describe "Reports API", type: :request do
  # initialize test data
  let!(:report) { create(:report) }
  let!(:report_id) { report.id }

  let!(:report_2) { create(:report, medical_record: report.medical_record) }
  let!(:report_3) { create(:report, medical_record: report.medical_record) }

  before :each do
    stub_access_token
  end

  # Test suite for GET /v1/reports
  describe "GET /v1/reports" do
    # make HTTP get request before each example
    before { get "/v1/reports", params: { medical_record: report.medical_record.id } }

    it "returns reports" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/users/:id
  describe "GET /v1/reports/:id" do
    before { get "/v1/reports/#{report_id}" }

    context "when the record exists" do
      it "returns the report" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(report_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:report_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Report/)
      end
    end
  end

end
