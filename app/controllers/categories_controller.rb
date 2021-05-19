class CategoriesController < ApplicationController
  before_action :check_category, except: %i[index create]

  def index
    categories = current_user.categories
    render json: categories
  end

  def create
    category = current_user.categories.create!(category_params)
    render json: category, status: :created
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def show
    render json: @category
  end

  def update
    @category.update!(category_params)
    render json: @category, status: :accepted
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def destroy
    @category.destroy!
    render json: {}, status: :no_content
  rescue ActiveRecord::RecordNotFound => e
    bad_request_error(e)
  end

  private

  def check_category
    @category = current_user.categories.find(params[:id])
    true
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: ['Category does not exist or does not belong to user']}, status: :not_found
    false
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
