class UserController < ApplicationController
  def show
    render json: current_user, include: :currencies
  end

  def update
    current_user.update!(user_params)
    render json: current_user
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar, :primary_currency_id)
  end
end
