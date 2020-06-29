# frozen_string_literal: true

module API
  module V1
    class ProductsController < ApplicationController
      def create
        product = Product.new(product_params)

        if product.save
          render json: product, status: :created
        else
          render json: product.errors, status: :unprocessable_entity
        end
      end

      def product_params
        params.require(:data).require(:attributes).permit(:name, :description, :price)
      end
    end
  end
end
