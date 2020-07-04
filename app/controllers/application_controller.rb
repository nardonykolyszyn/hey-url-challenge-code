# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: {
      message: 'URL not found', status: :not_found
    }
  end
end
