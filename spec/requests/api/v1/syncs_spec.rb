require "rails_helper"

RSpec.describe "Syncs API", type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let!(:syncs) { create_list(:sync, 5) }

  subject { syncs }

  before :each do
    stub_access_token
    stub_current_user(user)
  end

  # Test suite for GET /v1/syncs
  describe "GET /v1/syncs" do
    before { get "/v1/syncs" }

    it "returns all syncs" do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for POST /v1/syncs
  describe "POST /v1/syncs" do
    let(:attributes) { { sync: { sync_date: Time.now, description: "New Sync!" } } }

    before { post "/v1/syncs", params: attributes }

    it "creates the sync" do
      expect(response.body).to match(/New Sync!/)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(201)
    end
  end

  # Test suite for GET /v1/latest_updates
  describe "GET /v1/latest_updates" do
    before { get "/v1/latest_updates" }

    it "returns all syncs" do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/last_sync
  describe "GET /v1/last_sync" do
    before { get "/v1/last_sync" }

    it "returns last sync" do
      expect(json).not_to be_empty
      expect(json.size).to eq(4)
      expect(json["sync_date"]).to match(/#{syncs.last.sync_date.strftime("%FT%TZ")}/)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end
end
