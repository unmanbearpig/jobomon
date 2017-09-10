class ApiController < ApplicationController
  USER_ERRORS = [
    ActiveModel::UnknownAttributeError,
    ActiveRecord::RecordInvalid
  ]

  protect_from_forgery false

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
