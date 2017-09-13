class SourcesController < ApiController
  def index
    render json: Source.all
  end

  def create
    new_source = Source.create!(source_params)
    render json: new_source
    FetchJobOffersWorker.perform_async(new_source.id)
  end

  def show
    render json: Source.find(params.fetch(:id)), include_job_offers: true
  end

  private

  def source_params
    params.require(:source).permit(:title, :url, :source_type)
  end
end
