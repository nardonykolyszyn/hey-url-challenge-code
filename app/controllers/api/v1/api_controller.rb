# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::Metal
      include ActionController::StrongParameters
      include AbstractController::Rendering
      include ActionController::Rescue
      include ActionController::Instrumentation
      include ActionController::Renderers::All
      include ActionController::Redirecting
    end
  end
end
