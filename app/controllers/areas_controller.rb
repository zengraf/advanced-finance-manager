class AreasController < ApplicationController
  before_action :check_area, except: %i[index create]

  def index
    areas = current_user.areas
    render json: areas
  end

  def create
    area = current_user.areas.create!(area_params)
    render json: area, status: :created
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

    response = @area.as_json
    response[:total] = @area.total_for_area(from, to)
    categories_sums = @area.total_for_categories(from, to)
    response[:categories] = categories_sums.map { |k, v| k.as_json.merge({total: v})  }

    render json: response
  rescue Date::Error => e
    render json: { errors: ['Invalid date']}, status: :bad_request
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
    render json: { errors: ['Area does not exist']}, status: :not_found
    false
  end

  def area_params
    params.require(:area).permit(:name)
  end

  def period_params
    params.permit(:from, :to)
  end
end
