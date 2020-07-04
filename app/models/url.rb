# frozen_string_literal: true

class Url < ApplicationRecord
  # Callback
  after_initialize :generate_original_url_scheme
  around_create    :generate_short_url

  validates :original_url, presence: true, format: {
    with: /\A[\:\/\/'a-zA-Z0-9'\.]*\z/,
    message: 'original_url has non-valid characters or any scheme'
  }
  # Associations
  has_many :clicks
  # Scopes
  def newest_clicks
    clicks.where('created_at >= ? AND created_at <= ?', Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
  end

  # It force HTTP protocol in case it is blank (https || http)
  def shortened_url
    Shortener.scheme_builder(original_url).build(
      host: ENV.fetch('APP_HOST') { 'localhost' },
      path: "/#{short_url}",
      port: ENV['APP_PORT']
    ).to_s
  end

  def register_counter_click
    self.class.increment_counter(:clicks_count, id)
  end

  def register_click(browser)
    clicks.build(
      browser: browser.name,
      platform: browser.platform.id
    ).save
  end

  private

  def generate_original_url_scheme
    self.original_url = Shortener.clean_url(original_url) if original_url
  end

  def generate_short_url
    self.short_url = loop do
      random_token = Shortener.generate_short_option

      break random_token unless self.class.exists?(short_url: random_token)
    end
    yield
  end
end
