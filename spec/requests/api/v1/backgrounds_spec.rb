require "rails_helper"

RSpec.describe "Backgrounds API", type: :request do
  # initialize test data
  let!(:background) { create(:background) }
  let!(:background_id) { background.id }

  let!(:background_2) { create(:background, medical_record: background.medical_record) }
  let!(:background_3) { create(:background, medical_record: background.medical_record) }

  before :each do
    stub_access_token
  end

  # Test suite for GET /v1/backgrounds
  describe "GET /v1/backgrounds" do
    # make HTTP get request before each example
    before { get "/v1/backgrounds", params: { record: background.medical_record.id } }

    it "returns backgrounds" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/backgrounds/:id
  describe "GET /v1/backgrounds/:id" do
    before { get "/v1/backgrounds/#{background_id}" }

    context "when the record exists" do
      it "returns the background" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(background_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:background_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Background/)
      end
    end
  end

  # Test suite for PUT /v1/backgrounds/:id
  describe "PUT /v1/backgrounds/:id" do
    let(:valid_attributes) { { background: { description: "Updated description" } } }

    context "when the record exists" do
      before { put "/v1/backgrounds/#{background_id}", params: valid_attributes }

      it "updates the background" do
        expect(response.body).to be_empty
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end
    end
  end

end
