# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: [{ detail: exception.message }] }, status: :unprocessable_entity
  end
end
