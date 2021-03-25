# frozen_string_literal: true

class Api::DrinksController < ApiController
  before_action :set_drink, only:  %i[show]
  skip_before_action :authorize, only: %i[index show]

  def index
    drinks = Drink.all
    render json: drinks
  end

  def show
    drink_json=(JSON.parse @drink.to_json)
    drink_json["avg"] = @drink.rating_avg
    drink_json["reviews"] =  @drink.reviews
    render json: drink_json
  end

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end
end
