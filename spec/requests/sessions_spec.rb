require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do

  # initialize test data
  let!(:user) { create(:user, password: 'qwerty123') }

  before :each do
    stub_access_token
    stub_current_user(user)
  end

  # Test suite for POST /sign-in
  describe 'POST /sign-in' do
    # valid payload
    let(:valid_attributes) { { user_login: { email: user.email, password: 'qwerty123' } } }

    context 'when the request is valid' do
      before { post '/sign-in', params: valid_attributes }

      it 'creates a authentication token access' do
        expect(json['auth_token'].empty?).to be_falsey
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      before { post '/sign-in', params: { user_login: { email: user.email, password: 'wrongpass' } } }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Error with your login or password/)
      end
    end
  end

  # Test suite for DELETE /sign-out
  describe 'DELETE /sign-out' do
    before { delete "/sign-out" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

end
