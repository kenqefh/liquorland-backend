# frozen_string_literal: true

class Api::DrinksController < ApiController
  before_action :set_drink, only:  %i[show]
  skip_before_action :authorize, only: %i[index show search top_most_high_rated top_recent_drinks best_sellings]

  def index
    @drinks = Drink.all
    render_drinks
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
    @drinks = Drink.where('lower(name) like ?', "%#{(params[:name] || '').downcase}%").order(:name)
    render_drinks
  end

  def top_recent_drinks
    drinks = Drink
    .order(created_at: :desc)
    .limit(params[:limit] || 3)

    @result = {
      id: 1,
      name: 'Top New Drinks',
      description: 'Our new and future releases. Updated hourly',
      drinks: drinks
    }
    render_result
  end

  def best_sellings
    drinks = Drink
    .left_joins(:sale_drinks)
    .group(:id)
    .order('COUNT(sale_drinks.id) DESC')
    .limit(params[:limit] || 3)

    @result = {
      id: 2,
      name: 'Best sellings',
      description: 'Our most popular products based on sales. Updated hourly.',
      drinks: drinks
    }
    render_result
  end

  def top_most_high_rated
    drinks = Drink.all.sort_by { |drink| drink.rating_avg }.reverse.first(params[:limit].to_i || 3)

    @result = {
      id: 3,
      name: 'Most Rating Drinks',
      description: 'The problem with the world is that everyone is a few drinks behind.',
      drinks: drinks
    }
    render_result
  end

  private
    def set_drink
      @drink = Drink.find(params[:id])
    end

    def render_result
      render json: @result,
      except: %i[brand_id style_id category_id],
      include: {
        brand: { only: [:id, :name] },
        style: { only: [:id, :name] },
        category: { only: [:id, :name] },
      },
      methods: [:image_url, :rating_avg]
    end

    def render_drinks
      render json: @drinks,
      except: %i[brand_id style_id category_id],
      include: {
        brand: { only: [:id, :name] },
        style: { only: [:id, :name] },
        category: { only: [:id, :name] },
      },
      methods: [:image_url, :rating_avg]
    end
end
