class Api::CartsController < ApiController
  before_action :set_cart, only: %i[destroy update]

  def index
    render json: current_user.carts,
    only: %i[id quantity created_at updated_at],
    include: {
      drink: { only: %i[id image name presentation price], methods: :image_url }
    }
  end

  def create
    cart = current_user.carts.create(cart_params)
    if cart.valid?
      cart.save
      render json: cart, only: %i[id quantity created_at updated_at],
      include: {
        drink: { only: %i[id image name presentation price] }
      }, status: :created
    else
      render json: cart.errors, status: :unprocessable_entity
    end
  end

  def update
    if @cart.update(cart_params)
      render json: @cart, only: %i[id quantity created_at updated_at],
      include: {
        drink: { only: %i[id image name presentation price] }
      }, status: :ok
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @cart.destroy
    head :no_content
  end

  private
    def cart_params
      params.require(:cart).permit(:drink_id, :quantity)
    end

    def set_cart
      @cart = current_user.carts.find(params[:id])
    end
end
