# frozen_string_literal: true

class TagSerializer < ActiveModel::Serializer
  attributes :title

  has_many :products
end
