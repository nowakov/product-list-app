# frozen_string_literal: true

class UpdateProduct < BaseService
  context :product, :update_params

  def call
    assign_tags if update_params[:tags].present?
    product.assign_attributes(update_params)

    if product.save
      @output[:product] = product
    else
      @errors[:product] = product
    end
  end

  private

  def assign_tags
    tag_titles = update_params.delete(:tags)

    product.tags << tag_titles.map { |title| Tag.find_or_initialize_by(title: title) }
  end
end
