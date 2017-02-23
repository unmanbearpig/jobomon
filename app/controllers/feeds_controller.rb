class FeedsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: feeds
      end
    end
  end

  def create
    render json: Feed.create!(feed_params)
  end

  def delete
    raise NotImplementedError
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
