# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActionController::ParameterMissing do |exception|
    render json: { errors: [{ detail: exception.message }] }, status: :unprocessable_entity
  end

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { errors: [{ id: params[:id], detail: 'record not found' }] }, status: :not_found
  end
end
