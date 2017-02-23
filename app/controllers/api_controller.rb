class ApiController < ApplicationController
  USER_ERRORS = [
    ActiveModel::UnknownAttributeError,
    ActiveRecord::RecordInvalid
  ]

  rescue_from(*USER_ERRORS) do |error|
    render_error(400, error)
  end

  private

  def render_error(status, error)
    render status: status,
           json: { error: error.message }
  end
end
