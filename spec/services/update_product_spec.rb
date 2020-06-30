# frozen_string_literal: true

require 'rails_helper'

describe UpdateProduct do
  let(:product) { Fabricate(:product, name: 'Pepsi') }
  let(:update_params) do
    {
      name: 'Pepsi Zero'
    }
  end
  let(:service_call) { described_class.with(product: product, update_params: update_params) }

  it 'changes products name' do
    expect { service_call }.to change { product.name }.from('Pepsi').to('Pepsi Zero')
  end
end
