# frozen_string_literal: true

class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  validates :price, presence: true, numericality: true
end
