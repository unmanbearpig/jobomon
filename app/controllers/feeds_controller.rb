class FeedsController < ApplicationController
  def index
    respond_to do |format|
      format.json do
        render json: feeds, each_searializer: FeedSerializer
      end
    end
  end

  def create
    raise NotImplementedError
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
end
