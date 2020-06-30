# frozen_string_literal: true

class DestroyProduct < BaseService
  context :product

  def call
    product.transaction do
      product.tags.clear
      product.destroy
    end
  rescue StandardError
    @errors[:base] = 'Failed to destroy product'
  end
end
