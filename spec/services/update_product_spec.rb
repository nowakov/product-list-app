# frozen_string_literal: true

require 'rails_helper'

describe UpdateProduct do
  let(:product) { Fabricate(:product, name: 'Pepsi') }
  let(:tag) { Fabricate(:tag) }
  let(:update_params) do
    {
      name: 'Pepsi Zero',
      tags: ["Beverage", "Calorie Free"]
    }
  end
  let(:service_call) { described_class.with(product: product, update_params: update_params) }

  before { tag }

  it 'changes products name' do
    expect { service_call }.to change { product.name }.from('Pepsi').to('Pepsi Zero')
  end

  it 'assigns existing tag to product' do
    expect{service_call}.to change{product.reload.tags}.from([]).to [tag]
  end
end
