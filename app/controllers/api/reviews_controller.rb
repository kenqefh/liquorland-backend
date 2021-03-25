class Api::ReviewsController < ApiController
  before_action :set_review, only: %i[update destroy]
  skip_before_action :authorize, only: %i[index]

  def index
    drink = Drink.find(params[:drink_id])
    reviews = drink.reviews
    render json: reviews
  end


  def create
    drink = Drink.find(params[:drink_id])
    review = Review.new(review_params)
    review.drink = drink
    review.user = current_user
    if review.save
      render json: review, status: :created
    else
      render json: review.errors, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: @review, status: :ok
    else
      render json: @review.errors,  status: :bad_request
    end
  end

  def destroy
    @review.destroy
    head :no_content, status: :no_content
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  
end