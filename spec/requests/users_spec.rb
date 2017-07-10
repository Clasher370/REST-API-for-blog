require 'rails_helper'

RSpec.describe 'API::V1::Users', type: :request do
  describe 'POST /users' do
    let(:valid_attributes) { { nickname: 'foo', email: 'foo@bar.com',
                               password:'secret', password_confirmation:'secret' } }

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a post' do
        expect(JSON.parse(response.body)['nickname']).to eq('foo')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { title: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      # it 'returns a validation failure message' do
      #   expect(response.body)
      #       .to match(/'body': ['can't by blank']/)
      # end
    end
  end
end