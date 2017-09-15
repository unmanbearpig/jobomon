class JobOffersController < ApiController
  def index
    render json: JobOffer.all
  end
end
