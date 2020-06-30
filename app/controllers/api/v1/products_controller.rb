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

        if product.update(product_params)
          render json: product, status: :ok
        else
          render json: product,
                 serializer: ActiveModel::Serializer::ErrorSerializer,
                 status: :unprocessable_entity
        end
      end

      def product_params
        params.require(:data).require(:attributes).permit(:name, :description, :price)
      end
    end
  end
end
