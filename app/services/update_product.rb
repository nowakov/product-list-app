# frozen_string_literal: true

class UpdateProduct < BaseService
  context :product, :update_params

  def call
    map_tags_to_records if update_params[:tags].present?

    if product.update(update_params)
      @output[:product] = product
    else
      @errors[:product] = product
    end
  end

  private

  def map_tags_to_records
    update_params[:tags] = update_params[:tags].map do |tag_title|
      Tag.find_or_initialize_by(title: tag_title)
    end.compact
  end
end
