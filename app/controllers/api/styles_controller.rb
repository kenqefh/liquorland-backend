class Api::StylesController < ApiController
  before_action :set_style, only:  %i[show]
  skip_before_action :authorize, only: %i[index show]

  def index
    styles = Style.all
    render json: styles
  end

  def show
    render json: @style
  end

  private
    def set_style
      @style = Style.find(params[:id])
    end
    def style_params
      params_require(:style).permit(:body)
    end
end
