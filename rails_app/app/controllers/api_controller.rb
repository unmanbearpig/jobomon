class ApiController < ApplicationController
  include Knock::Authenticable
  # before_action :authenticate_user

  USER_ERRORS = [
    ActiveModel::UnknownAttributeError,
    ActiveRecord::RecordInvalid
  ]

  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  rescue_from(*USER_ERRORS) do |error|
    render_error(400, error)
  end

  rescue_from(ActiveRecord::RecordNotFound) do |error|
    render_error(404, error)
  end

  private

  def render_error(status, error)
    render status: status,
           json: { error: error.message }
  end
end
