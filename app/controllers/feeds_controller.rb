class FeedsController < ApiController
  def index
    render json: feeds
  end

  def create
    render json: Feed.create!(feed_params)
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
end
