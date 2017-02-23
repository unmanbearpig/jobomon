class FeedsController < ApplicationController
  def index
    render json: feeds
  end

  def create
    render json: Feed.create!(feed_params)
  rescue ActiveModel::UnknownAttributeError, ActiveRecord::RecordInvalid => error
    render_error(400, error)
  end

  def show
    render json: Feed.find(params.fetch(:id))
  end

  private

  def feeds
    @feeds ||= Feed.all
  end

  def feed_params
    params.require(:feed).permit(:title, :url)
  end

  def render_error(status, error)
    render status: status,
           json: { error: error.message }
  end
end
