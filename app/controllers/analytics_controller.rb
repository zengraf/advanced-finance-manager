class AnalyticsController < ApplicationController
  def index
    if params.has_key?(:from)
      from = params[:from].to_date
    else
      from = Date.current.beginning_of_month
    end

    if params.has_key?(:to)
      to = params[:to].to_date
    else
      to = from.end_of_month
    end

    if params.has_key?(:currency_id)
      currency = Currency.find(params[:currency_id])
    else
      currency = current_user.primary_currency
    end

    response = {currency: currency}
    transactions = current_user.transactions.months(from, to).includes(account: {currency: :selling_rates}, area: {}, category: {})

    response[:areas] = transactions.group_by(&:area).map do |area, transactions|
      area.as_json.merge({total: sum_with_conversion(transactions, currency)})
    end

    response[:categories] = transactions.group_by(&:category).map do |category, transactions|
      category.as_json.merge({total: sum_with_conversion(transactions, currency)})
    end

    render json: response
  rescue Date::Error
    render json: { errors: ['Invalid date']}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist']}, status: :not_found
  end

  private

  def sum_with_conversion(transactions, target_currency)
    transactions.map do |transaction|
      transaction.amount * (transaction.account.currency.selling_rates.find { |rate| rate.to_id == target_currency.id }&.rate || 1.0)
    end.sum
  end
end
