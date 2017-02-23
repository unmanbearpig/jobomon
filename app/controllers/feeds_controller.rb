class FeedsController < ApplicationController
  def index
    render json: feeds
  end

  def create
    render json: Feed.create!(feed_params)
  end

  def show
    raise NotImplementedError
  end

  private

  def feeds
    @feeds ||= Feed.all
  end

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
