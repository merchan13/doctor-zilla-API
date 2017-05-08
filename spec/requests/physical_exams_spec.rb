require 'rails_helper'

RSpec.describe 'PhysicalExams API', type: :request do
  # initialize test data
  let!(:physical_exam) { create(:physical_exam) }
  let!(:physical_exam_id) { physical_exam.id }

  let!(:physical_exam_2) { create(:physical_exam, consultation: physical_exam.consultation) }
  let!(:physical_exam_3) { create(:physical_exam, consultation: physical_exam.consultation) }

  before :each do
    stub_access_token
  end

  # Test suite for GET /physical_exams
  describe 'GET /physical_exams' do
    # make HTTP get request before each example
    before { get '/physical_exams', params: { consultation: physical_exam.consultation.id } }

    it 'returns physical_exams' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /physical_exams/:id' do
    before { get "/physical_exams/#{physical_exam_id}" }

    context 'when the record exists' do
      it 'returns the physical_exam' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(physical_exam_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:physical_exam_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find PhysicalExam/)
      end
    end
  end

  # Test suite for PUT /users/:id
  describe 'PUT /physical_exams/:id' do
    let(:valid_attributes) { { physical_exam: { observation: 'Updated observation' } } }

    context 'when the record exists' do
      before { put "/physical_exams/#{physical_exam_id}", params: valid_attributes }

      it 'updates the physical_exam' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

end
