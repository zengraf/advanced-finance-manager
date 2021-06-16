class AnalyticsController < ApplicationController
  def index
    if period_params.has_key?(:from)
      from = Date.period_params(params[:from])
    else
      from = Date.current.beginning_of_month
    end
    if period_params.has_key?(:to)
      to = Date.period_params(params[:to])
    else
      to = from.end_of_month
    end

    currencyId = params[:currencyId] || current_user.currencies.first.id
    currency = current_user.currencies.find(currencyId)

    response = {currency: currency}
    response[:areas] = transactions(from, to).with_exchange_rate(currencyId)
                                             .group(:area).sum("transactions.amount * rate")
                                             .map{|k, v| k.as_json.merge({total: v})}
    response[:categories] = transactions(from, to).with_exchange_rate(currencyId)
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

  def period_params
    params.permit(:from, :to)
  end

end
