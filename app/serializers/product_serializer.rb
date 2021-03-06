# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :name, :description, :price

  has_many :tags
end
