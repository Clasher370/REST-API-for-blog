require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  describe 'POST /signup' do
    let(:valid_attributes) { { nickname: 'foo', email: 'foo@bar.com',
                               password:'secret', password_confirmation:'secret' } }

    context 'when the request is valid' do
      before { post '/signup', params: valid_attributes }

      it 'creates a user' do
        expect(JSON.parse(response.body)['message']).to eq('Account created successfully')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/signup', params: { email: 'Foobar', password: 'secret' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(JSON.parse(response.body)['message'])
            .to match(/Nickname can't be blank/)
      end
    end
  end
end