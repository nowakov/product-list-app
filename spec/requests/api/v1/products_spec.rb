# frozen_string_literal: true

require 'rails_helper'

describe 'Products' do
  describe 'GET /api/v1/products' do
    let(:request_call) do
      get(api_v1_products_url)
    end

    context 'when products exist' do
      before do
        Fabricate(:product, name: 'Pepsi')
        Fabricate(:product, name: 'Coke')
      end

      it 'returns status 200' do
        request_call

        expect(response.status).to eq(200)
      end

      it 'returns all products' do
        request_call

        expect(json_response[:data].size).to eq(Product.count)
      end
    end

    context 'when there are no products' do
      it 'returns status 200' do
        request_call

        expect(response.status).to eq(200)
      end

      it 'returns all products' do
        request_call

        expect(json_response[:data]).to eq([])
      end
    end
  end

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
      it 'returns status 201' do
        request_call

        expect(response.status).to eq(201)
      end

      it 'returns created object\'s id' do
        request_call

        expect(json_response[:data][:id]).not_to be_empty
      end
    end

    context 'when product with same name already exists' do
      before { Fabricate.create(:product, name: product_params[:data][:attributes][:name]) }

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
      before { product_params[:data][:attributes][:price] = 'invalid' }

      it 'return status 422' do
        request_call

        expect(response.status).to eq(422)
      end

      it 'returns specific error message' do
        request_call

        expect(json_response[:errors][0][:detail]).to eq('is not a number')
      end
    end

    context 'when attributes key is missing in params' do
      before { product_params[:data][:attributes] = nil }

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

  describe 'PATCH /api/v1/products/:id' do
    let(:product) { Fabricate(:product) }
    let(:new_name) { 'Pepsi Zero' }
    let(:product_params) do
      {
        data: {
          type: 'undefined',
          id: product.id,
          attributes: {
            name: new_name
          }
        }
      }
    end
    let(:request_call) do
      patch(api_v1_product_url(product), params: product_params.to_json,
                                         headers: { CONTENT_TYPE: 'application/json' })
    end

    context 'when params are valid' do
      it 'returns status 200' do
        request_call

        expect(response.status).to eq(200)
      end

      it 'returns same updated object\'s id' do
        request_call

        expect(json_response[:data][:id]).to eq(product.id.to_s)
      end

      it 'returns updated title' do
        request_call

        expect(json_response[:data][:attributes][:name]).to eq(new_name)
      end
    end
  end
end
