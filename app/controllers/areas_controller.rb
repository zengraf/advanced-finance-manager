class AreasController < ApplicationController
  before_action :check_area, except: %i[index create]

  def index
    area = current_user.categories
    render json: area
  end

  def create
    area = current_user.areas.create!(area_params)
    render json: area, status: :created
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def show
    render json: @area
  end

  def update
    @area.update!(category_params)
    render json: @area, status: :accepted
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def destroy
    @area.destroy!
    render json: {}, status: :no_content
  rescue ActiveRecord::RecordNotFound => e
    bad_request_error(e)
  end

  private

  def check_area
    @area = current_user.areas.find(params[:id])
    true
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: ['Area does not exist or does not belong to user']}, status: :not_found
    false
  end

  def area_params
    params.require(:area).permit(:name)
  end
end
