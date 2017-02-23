class SourcesController < ApiController
  def index
    render json: Source.all
  end

  def create
    render json: Source.create!(source_params)
  end

  def show
    render json: Source.find(params.fetch(:id))
  end

  private

  def source_params
    params.require(:source).permit(:title, :url, :source_type)
  end
end
