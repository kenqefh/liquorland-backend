# frozen_string_literal: true

class Api::SalesController < ApiController
  before_action :set_sale, only: %i[show]

  def create
    sale = current_user.sales.create(sale_params)
    if sale.valid?
      sale.save
      render json: sale, status: :created
    else
      render json: sale.errors, status: :unprocessable_entity
    end
  end

  def index
    render json: current_user.sales
  end

  def show
    render json: @sale, status: :ok
  end

  private
    def sale_params
      params.require(:sale).permit(:total, :code)
    end

    def set_sale
      @sale = current_user.sales.find(params[:id])
    end
end
