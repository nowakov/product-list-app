# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :products

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
