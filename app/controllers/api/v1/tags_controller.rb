# frozen_string_literal: true

module API
  module V1
    class TagsController < ApplicationController
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

      def tag_params
        params.require(:data).require(:attributes).permit(:title)
      end
    end
  end
end
