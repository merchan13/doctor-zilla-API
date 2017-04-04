=begin
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  # initialize test data
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  # Test suite for GET /v1/users
  describe 'GET /v1/users' do
    before { get :index }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /v1/users/:id
  describe 'GET /v1/users/:id' do
    before { get :show, params: {id: user_id} }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for POST /v1/users
  describe 'POST /v1/users' do
    # valid payload
    let(:valid_attributes) { {  email:                  'johndoe@example.com',
                                password:               'qwerty123',
                                password_confirmation:  'qwerty123',
                                document:               'V-11111111',
                                name:                   'John',
                                lastname:               'Doe',
                                phone:                  '55 555 5555555',
                                role:                   'Doctor' } }

    context 'when the request is valid' do
      before { post :create, params: valid_attributes }

      it 'creates a user' do
        expect(json['email']).to eq('johndoe@example.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post :create, params: {email: 'johndoe@example'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Password can't be blank/)
      end
    end
  end

  # Test suite for PUT /v1/users/:id
  describe 'PUT /v1/users/:id' do

    context 'when the record exists' do
      before { put :update, params: {id: user_id, name: 'Jane'} }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /v1/users/:id
  describe 'DELETE /v1/users/:id' do
    before { delete :destroy, params: {id: user_id } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end

-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
=end
