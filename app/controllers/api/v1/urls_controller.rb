# frozen_string_literal: true

module Api
  module V1
    class UrlsController < ApiController
      def index
        collection = Url.all.order(clicks_count: :desc).limit(10)

        render json: {
          result: UrlSerializer.new(collection, {include: [:clicks]})
        }, status: :ok
      end
    end
  end
end
