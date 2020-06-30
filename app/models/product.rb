# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :price, presence: true, numericality: true
end
