# frozen_string_literal: true

class Tag < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
