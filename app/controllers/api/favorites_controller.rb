class Api::FavoritesController < ApiController
  before_action :set_favorite, only: %i[destroy update]

  def index
    render json: current_user.favorites,
    include: {
      drink: { only: %i[id image name presentation price], methods: :image_url }
    }
  end

  def create
    favorite = current_user.favorites.create(favorites_params)
    if favorite.valid?
      favorite.save
      render json: favorite,
      include: {
        drink: { only: %i[id image name presentation price], methods: :image_url }
      }, status: :created
    else
      render json: favorite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @favorite.destroy
    head :no_content
  end

  private
    def favorites_params
      params.require(:favorite).permit(:drink_id)
    end

    def set_favorite
      @favorite = current_user.favorites.find(params[:id])
    end
end
