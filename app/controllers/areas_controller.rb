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

    currency_id = params[:currencyId] || current_user.currencies.first.id
    currency = current_user.currencies.find(currency_id)

    response = {currency: currency}
    area_transactions = @area.transactions.months(from, to).includes(account: {currency: :selling_rates}, area: {}, category: {})

    response[:area] = @area.as_json.merge({total: sum_with_conversion(area_transactions, currency)})
    response[:area][:categories] = area_transactions.group_by(&:category).map do |category, transactions|
      category.as_json.merge({total: sum_with_conversion(transactions, currency)})
    end

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

  def sum_with_conversion(transactions, target_currency)
    transactions.map do |transaction|
      transaction.amount * (transaction.account.currency.selling_rates.find { |rate| rate.to_id == target_currency.id }&.rate || 1.0)
    end.sum
  end
end
