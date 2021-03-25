class Api::SalesController < ApiController
  before_action :set_sale, only: %i[show]

  def index
    render json: Sale.all
  end

  def show
    render json: @sale, status: :ok
  end

  private
    def set_sale
      @sale = Sale.find(params[:id])
    end
end
