require 'rails_helper'

RSpec.describe 'API::V1::Posts', type: :request do
  let(:user) { create(:user) }
  let!(:posts) { create_list(:post, 10, author_id: user.id) }
  let(:post_id) { posts.first.id }
  let(:headers)  { valid_headers }

  describe 'GET /api/v1/posts' do
    before { get '/api/v1/posts', params: {}, headers: headers }

    it 'returns posts' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/posts:id' do
    before { get "/api/v1/posts/#{post_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the post' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(post_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:post_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to match(/Couldn't find Post with 'id'=100/)
      end
    end
  end

  describe 'POST /api/v1/posts' do
    let(:valid_attributes) { { title: 'test title', body: 'test', author_id: user.id } }

    context 'when the request is valid' do
      before { post '/api/v1/posts', params: valid_attributes, headers: headers }

      it 'creates a post' do
        expect(JSON.parse(response.body)['title']).to eq('test title')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/posts', params: { title: 'Foobar' }, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(JSON.parse(response.body)['message'])
            .to match(/Validation failed: Body can't be blank/)
      end
    end
  end
end
