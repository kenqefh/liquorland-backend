# frozen_string_literal: true

class Api::DrinksController < ApiController
  before_action :set_drink, only:  %i[show]
  skip_before_action :authorize, only: %i[index show top_recent_drinks best_sellings]

  def top_recent_drinks
    drinks = Drink
    .order(created_at: :desc)
    .limit(params[:limit] || 3)

    result = {
      id: 1,
      name: 'Top New Drinks',
      description: "When we drink we get drunk. When we get drunk we fall asleep. When we fall asleep we commit no sin. When we commit no sin we go to heaven. Sooooo, let's all get drunk and go to heaven!",
      drinks: drinks
    }
    render json: result,
    except: %i[brand_id style_id category_id],
    include: {
      brand: { only: [:id, :name] },
      style: { only: [:id, :name] },
      category: { only: [:id, :name] },
    },
    methods: [:image_url, :rating_avg]
  end

  def best_sellings
    drinks = Drink
    .left_joins(:sale_drinks)
    .group(:id)
    .order('COUNT(sale_drinks.id) DESC')
    .limit(params[:limit] || 3)

    result = {
      id: 1,
      name: 'Best sellings',
      description: 'Reality is an illusion that occurs due to lack of alcohol.',
      drinks: drinks
    }
    render json: result,
    except: %i[brand_id style_id category_id],
    include: {
      brand: { only: [:id, :name] },
      style: { only: [:id, :name] },
      category: { only: [:id, :name] },
    },
    methods: [:image_url, :rating_avg]
  end

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

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end
end
