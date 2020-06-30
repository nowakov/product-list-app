# frozen_string_literal: true

module API
  module V1
    class TagsController < ApplicationController
      def index
        render json: Tag.all, status: :ok
      end

      def create
        tag = Tag.new(tag_params)

        if tag.save
          render json: tag, status: :created
        else
          render json: tag,
                 serializer: ActiveModel::Serializer::ErrorSerializer,
                 status: :unprocessable_entity
        end
      end

      def update
        tag = Tag.find(params[:id])

        if tag.update(tag_params)
          render json: tag, status: :ok
        else
          render json: tag,
                 serializer: ActiveModel::Serializer::ErrorSerializer,
                 status: :unprocessable_entity
        end
      end

      def tag_params
        params.require(:data).require(:attributes).permit(:title)
      end
    end
  end
end
