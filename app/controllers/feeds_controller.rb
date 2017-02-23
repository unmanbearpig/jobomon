class FeedsController < ApiController
  def index
    render json: Feed.all
  end

  def create
    render json: Feed.create!(feed_params)
  end

  def show
    render json: Feed.find(params.fetch(:id))
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
