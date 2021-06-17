class WishesController < ApplicationController
  before_action :check_wish, only: %i[show update destroy]

  def index
    render json: current_user.wishes
  end

  def show
    render json: @wish
  end

  def create
    created_wish = current_user.wishes.create!(wish_params)
    render json: created_wish, status: :created
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def update
    @wish.update!(wish_params)
    render json: @wish, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def destroy
    @wish.destroy!
    render json: {}, status: :no_content
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  private

  def check_wish
    @wish = current_user.wishes.find(params[:id])
    true
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Wish does not exist or does not belong to this user'] }, status: :not_found
    false
  end

  def wish_params
    params.require(:wish).permit(:amount, :description, :url, :currency_id)
  end
end
