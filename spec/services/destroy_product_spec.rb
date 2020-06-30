# frozen_string_literal: true

require 'rails_helper'

describe DestroyProduct do
  let(:product) { Fabricate(:product, name: 'Pepsi') }
  let(:service_call) { described_class.with(product: product) }

  it 'deletes product' do
    product

    expect { service_call }.to change { Product.find_by(name: 'Pepsi') }.to(nil)
  end

  context 'when product has tags' do
    before do
      product.tags << Fabricate(:tag)
      product.save
    end

    it 'deletes product' do
      product

      expect { service_call }.to change { Product.find_by(name: 'Pepsi') }.to(nil)
    end

    it 'doesn\'t remove any tag from db' do
      expect { service_call }.not_to(change { Tag.count })
    end
  end

  context 'when something goes wrong' do
    before { allow(product).to receive(:destroy).and_raise(StandardError) }

    it 'doesn\'t delete product' do
      product

      expect { service_call }.not_to change { Product.exists?(name: 'Pepsi') }.from(true)
    end

    it 'doesn\'t remove product\'s tags' do
      product.tags << Fabricate(:tag)
      product.save

      expect { service_call }.not_to change { product.tags.count }.from(1)
    end
  end
end
