class CurrenciesController < ApplicationController
  before_action :check_currency, only: %i[show destroy]

  def index
    render json: Currency.all
  end

  def show
    render json: @currency, include: [:selling_rates, :purchase_rates]
  end

  def create
    current_user.currencies << Currency.find(params[:id])
    render json: current_user.currencies, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist'] }, status: :not_found
  end

  def destroy
    current_user.currencies.destroy(@currency.id)
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
