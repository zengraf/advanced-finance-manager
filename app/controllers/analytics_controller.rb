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

    currency_id = params[:currencyId] || current_user.currencies.first.id
    currency = current_user.currencies.find(currency_id)

    response = {currency: currency}
    response[:areas] = transactions(from, to).with_exchange_rate(currency_id)
                                             .group(:area).sum("transactions.amount * rate")
                                             .map{|k, v| k.as_json.merge({total: v})}
    response[:categories] = transactions(from, to).with_exchange_rate(currency_id)
                                                  .group(:category).sum("transactions.amount * rate")
                                                  .map{|k, v| k.as_json.merge({total: v})}
    render json: response
  rescue Date::Error
    render json: { errors: ['Invalid date']}, status: :bad_request
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist or does not belong to this user']}, status: :not_found
  end


  private

  def transactions(from, to)
    current_user.transactions.months(from, to)
  end
end
