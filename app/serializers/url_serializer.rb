# frozen_string_literal: true

class UrlSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :created_at, :original_url, :short_url
  has_many :clicks, serializer: ClickSerializer

  attribute :shortened_url do |object|
    object.shortened_url
  end
end
