# frozen_string_literal: true

class Api::BrandsController < ApiController
  before_action :set_brand, only:  %i[show]
  skip_before_action :authorize, only: %i[index show]

  def index
    brands = Brand.all
    render json: brands
  end

  def show
    render json: @brand
  end

  private
    def set_brand
      @brand = Brand.find(params[:id])
    end
    def brand_params
      params_require(:brand).permit(:body)
    end
end
