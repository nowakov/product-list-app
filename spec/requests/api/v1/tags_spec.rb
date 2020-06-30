# frozen_string_literal: true

require 'rails_helper'

describe 'Tags' do
  describe 'POST /api/v1/tags' do
    let(:tag_params) do
      {
        data: {
          type: 'undefined',
          id: 'undefined',
          attributes: {
            title: 'Beverage'
          }
        }
      }
    end
    let(:request_call) do
      post(api_v1_tags_url, params: tag_params.to_json,
                            headers: { CONTENT_TYPE: 'application/json' })
    end

    context 'when params are valid' do
      it 'returns status 201' do
        request_call

        expect(response.status).to eq(201)
      end

      it 'returns created object\'s id' do
        request_call

        expect(json_response[:data][:id]).not_to be_empty
      end
    end

    context 'when tag with same title already exists' do
      before { Fabricate.create(:tag, title: tag_params[:data][:attributes][:title]) }

      it 'returns status 422' do
        request_call

        expect(response.status).to eq(422)
      end

      it 'returns specific error message' do
        request_call

        expect(json_response[:errors][0][:detail]).to eq('has already been taken')
      end
    end

    context 'when params are invalid' do
      before { tag_params[:data][:attributes][:title] = '' }

      it 'return status 422' do
        request_call

        expect(response.status).to eq(422)
      end

      it 'returns specific error message' do
        request_call

        expect(json_response[:errors][0][:detail]).to eq('can\'t be blank')
      end
    end

    context 'when attributes key is missing in params' do
      before { tag_params[:data][:attributes] = nil }

      it 'returns status 422' do
        request_call

        expect(response.status).to eq(422)
      end

      it 'returns specific error message' do
        request_call

        expect(json_response[:errors][0][:detail]).to eq('param is missing or the value is empty: attributes')
      end
    end
  end

  describe 'PATCH /api/v1/tags' do
    let(:tag) { Fabricate(:tag) }
    let(:new_title) { 'Updated title' }
    let(:tag_params) do
      {
        data: {
          type: 'undefined',
          id: tag.id,
          attributes: {
            title: new_title
          }
        }
      }
    end
    let(:request_call) do
      patch(api_v1_tag_url(tag), params: tag_params.to_json,
                                 headers: { CONTENT_TYPE: 'application/json' })
    end

    context 'when params are valid' do
      it 'returns status 200' do
        request_call

        expect(response.status).to eq(200)
      end

      it 'returns same updated object\'s id' do
        request_call

        expect(json_response[:data][:id]).to eq(tag.id.to_s)
      end

      it 'returns updated title' do
        request_call

        expect(json_response[:data][:attributes][:title]).to eq(new_title)
      end
    end
  end
end
