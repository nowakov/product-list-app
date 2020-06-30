# frozen_string_literal: true

class Product < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: true
end
