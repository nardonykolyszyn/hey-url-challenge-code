# frozen_string_literal: true

class Shortener
  CHARSET = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
  URL_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

  mattr_accessor :short_url_length
  self.short_url_length = 5

  def self.generate_short_option
    (0...short_url_length).map { CHARSET[rand(CHARSET.size)] }.join
  end

  def self.clean_url(url)
    url = url.to_s.strip

    url = "http://#{url}" if url !~ URL_HAS_PROTOCOL && url[0] != '/'

    url.to_s
  end

  def self.scheme_builder(url)
    builder = Rails.env == 'production' ? URI.parse(url).scheme.upcase : 'HTTP'

    URI.const_get(builder)
  end
end
