class CurrenciesController < ApplicationController
  before_action :check_currency, except: [:index, :show]

  def index
    render json: Currency.all
  end

  def show
    render json: Currency.includes(selling_rates: [:from, :to], purchase_rates: [:from, :to]).find(params[:id]), include: [:selling_rates, :purchase_rates]
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist'] }, status: :not_found
    false
  end

  def create
    current_user.currencies << @currency
    render json: current_user.currencies, status: :created
  end

  def destroy
    current_user.currencies.destroy(@currency.id)
    render json: {}, status: :no_content
  end

  private

  def check_currency
    @currency = Currency.find(params[:id])
    true
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist'] }, status: :not_found
    false
  end
end
