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

    currency_id = params[:currencyId] || current_user.currencies.first&.id || Currency.first.id
    currency = Currency.find(currency_id)

    response = {currency: currency}
    category_transactions = @category.transactions.months(from, to).includes(account: {currency: :selling_rates}, area: {}, category: {})

    response[:category] = @category.as_json.merge({total: sum_with_conversion(category_transactions, currency)})
    response[:category][:areas] = category_transactions.group_by(&:area).map do |area, transactions|
      area.as_json.merge({total: sum_with_conversion(transactions, currency)})
    end

    render json: response
  rescue Date::Error => e
    render json: { errors: ['Invalid date']}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist']}, status: :not_found
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
    render json: { errors: ['Category does not exist or does not belong to this user']}, status: :not_found
    false
  end

  def category_params
    params.require(:category).permit(:name, :limit)
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
