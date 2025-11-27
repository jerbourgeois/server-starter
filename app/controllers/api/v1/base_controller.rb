module Api
  module V1
    class BaseController < ApplicationController
      # Disable CSRF for API requests
      skip_before_action :verify_authenticity_token

      # Use JSON by default
      respond_to :json

      # Handle errors
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ActionController::ParameterMissing, with: :bad_request

      private

      def not_found
        render json: { error: "Record not found" }, status: :not_found
      end

      def bad_request
        render json: { error: "Bad request" }, status: :bad_request
      end
    end
  end
end
