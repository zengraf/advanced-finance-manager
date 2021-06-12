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

    response = {}
    response[:areas] = transactions(from, to).group(:area).sum(:amount).map{|k, v| k.as_json.merge({total: v})}
    response[:categories] = transactions(from, to).group(:category).sum(:amount).map{|k, v| k.as_json.merge({total: v})}

    render json: response
  rescue Date::Error => e
    render json: { errors: ['Invalid date']}, status: :bad_request
  end

  private

  def transactions(from, to)
    current_user.transactions.months(from, to)
  end

  def period_params
    params.permit(:from, :to)
  end
end
