class Api::CategoriesController < ApiController
  before_action :set_category, only:  %i[show]
  skip_before_action :authorize, only: %i[index show]

  def index
    categories = Category.all
    render json: categories
  end

  def show
    render json: @category
  end

  private

   def set_category
      @category = Category.find(params[:id])
    end

  def category_params
    params.require(:category).permit(:name, :description, :color, :cover)
  end

end