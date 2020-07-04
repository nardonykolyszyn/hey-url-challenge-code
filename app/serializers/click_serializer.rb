# frozen_string_literal: true

class ClickSerializer
  include FastJsonapi::ObjectSerializer
  attributes :created_at, :browser, :platform
  belongs_to :url
end
