# frozen_string_literal: true

class UpdateProduct < BaseService
  context :product, :update_params

  def call
    update_params[:tags] = update_params[:tags].map do |tag_title|
      Tag.find_by(title: tag_title)
    end.compact

    if product.update(update_params)
      @output[:product] = product
    else
      @errors[:product] = product
    end
  end
end
