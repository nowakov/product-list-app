# frozen_string_literal: true

module API
  module V1
    class ProductsController < ApplicationController
      def index
        render json: Product.all, status: :ok
      end

      def create
        product = Product.new(product_params)

        if product.save
          render json: product, status: :created
        else
          render json: product,
                 serializer: ActiveModel::Serializer::ErrorSerializer,
                 status: :unprocessable_entity
        end
      end

      def update
        product = Product.find(params[:id])

        result = UpdateProduct.with(product: product, update_params: product_params)

        if result.success?
          render json: result.output[:product], status: :ok
        else
          render json: product.errors[:product],
                 serializer: ActiveModel::Serializer::ErrorSerializer,
                 status: :unprocessable_entity
        end
      end

      private

      def product_params
        params.require(:data).require(:attributes).permit(:name, :description, :price, tags: [])
      end
    end
  end
end
