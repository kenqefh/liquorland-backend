# frozen_string_literal: true

class Api::SalesController < ApiController
  before_action :set_sale, only: %i[show]

  def create
    code = DateTime.now.to_s
    total = 0
    drinks = params[:drinks]
    sale = Sale.new(user_id: current_user.id, total: 0, code: code)
    drinks.each do |drink|
      sale_drink = SaleDrink.new(drink_id: drink[:id], quantity: drink[:quantity])
      sale.sale_drinks.push(sale_drink)

      total += Drink.find(drink[:id]).price * drink[:quantity]

      cart = current_user.carts.find_by(drink_id: drink[:id])
      raise StandardError, 'Not found item in the cart' if cart.nil?
      cart.destroy
    end

    sale.total = total
    if sale.save
      render json: sale, status: :created
    else
      render json: sale.errors, status: :unprocessable_entity
    end

  rescue StandardError => e
    error = { message: [e.message] }
    render json: error, status: :unprocessable_entity
  end

  def index
    render json: current_user.sales
  end

  def show
    render json: @sale, except: %i[user_id], include: {
      sale_drinks: {
        only: %i[id quantity],
        include: {
          drink: { except: %i[reviews_count updated_at created_at], methods: :image_url }
        }
      }
    }, status: :ok
  end

  private
    def set_sale
      @sale = current_user.sales.find(params[:id])
    end
end
