class FeedsController < ApiController
  def index
    render json: Feed.all
  end

  def create
    render json: Feed.create!(feed_params)
  end

  def show
    render json: Feed.find(params.fetch(:id)),
           include_sources: true,
           include_job_offers: true
  end

  private

  def feed_params
    params.require(:feed).permit(:title)
  end
end
