# frozen_string_literal: true

class Api::DrinksController < ApiController
  before_action :set_drink, only:  %i[show]
  skip_before_action :authorize, only: %i[index show]

  def index
    drinks = Drink.all
    render json: drinks
  end

  def show
    render json: @drink
  end

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end
end
