# frozen_string_literal: true

class Api::DrinksController < ApiController
  before_action :set_drink, only:  %i[show]
  skip_before_action :authorize, only: %i[index show search]

  def index
    drinks = Drink.all
    render json: drinks,
    except: %i[brand_id style_id category_id],
    include: {
      brand: { only: [:id, :name] },
      style: { only: [:id, :name] },
      category: { only: [:id, :name] },
    },
    methods: %i[rating_avg image_url]
  end

  def show
    render json: @drink,
    except: %i[brand_id style_id category_id],
    include: {
      brand: { only: [:id, :name] },
      style: { only: [:id, :name] },
      category: { only: [:id, :name] },
      reviews: { except: %i[user_id drink_id], include: { user: { only: %i[id name], methods: :avatar_url } } }
    },
    methods: %i[rating_avg image_url]
  end

  def search
    drinks = Drink.where('lower(name) like ?', "%#{(params[:name] || '').downcase}%").order(:name)

    render json: drinks, methods: [:image_url, :rating_avg]
  end

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end
end
