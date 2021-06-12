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
    if period_params.has_key?(:from)
      from = Date.parse(period_params[:from])
    else
      from = Date.current.beginning_of_month
    end
    if period_params.has_key?(:to)
      to = Date.parse(period_params[:to])
    else
      to = from.end_of_month
    end

    response = @category.as_json
    response[:total] = @category.total_for_category(from, to)
    areas_sums = @category.total_for_areas(from, to)
    response[:areas] = areas_sums.map { |k, v| k.as_json.merge({total: v})  }

    render json: response
  rescue Date::Error => e
    render json: { errors: ['Invalid date']}, status: :bad_request
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

  def period_params
    params.permit(:from, :to)
  end
end
