# frozen_string_literal: true

class UpdateProduct < BaseService
  context :product, :update_params

  def call
    if product.update(update_params)
      @output[:product] = product
    else
      @errors[:product] = product
    end
  end
end
