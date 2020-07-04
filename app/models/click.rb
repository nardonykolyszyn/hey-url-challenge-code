# frozen_string_literal: true

class Click < ApplicationRecord
  # Associations
  belongs_to :url, touch: true
end
