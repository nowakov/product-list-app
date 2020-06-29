# frozen_string_literal: true

require 'rails_helper'

describe 'POST /api/v1/products' do
  let(:product_params) do
    {
      data: {
        type: 'undefined',
        id: 'undefined',
        attributes: {
          name: 'Coke',
          description: '24oz Bottle',
          price: '1.98'
        }
      }
    }
  end
  let(:request_call) do
    post(api_v1_products_url, params: product_params.to_json,
                              headers: { CONTENT_TYPE: 'application/json' })
  end

  context 'when params are valid' do
    it 'returns status 200' do
      request_call

      expect(response.status).to eq(201)
    end

    it 'returns created object\'s id' do
      request_call

      expect(json_response[:data][:id]).not_to be_empty
    end
  end
end
