require "rails_helper"

RSpec.describe "Operative Note API", type: :request do
  # initialize test data
  let!(:operative_notes) { create_list(:operative_note, 2) }
  let(:operative_note_id) { operative_notes.first.id }

  subject { operative_notes }

  before :each do
    stub_access_token
  end

  # Test suite for GET /v1/operative_notes
  describe "GET /v1/operative_notes" do
    before { get "/v1/operative_notes" }

    it "returns operative_notes" do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it "returns status code 200" do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/operative_notes/:id
  describe "GET /v1/operative_notes/:id" do
    before { get "/v1/operative_notes/#{operative_note_id}" }

    context "when the record exists" do
      it "returns the medical operative_note" do
        expect(json).not_to be_empty
        expect(json["id"]).to eq(operative_note_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:operative_note_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find OperativeNote/)
      end
    end
  end

end
