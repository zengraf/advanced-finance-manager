class CurrenciesController < ApplicationController
  before_action :check_currency, only: %i[show destroy]

  def index
    render json: current_user.currencies
  end

  def show
    render json: @currency
  end

  def create
    current_user.currencies << Currency.find( params[:id])
    render json: current_user.currencies, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist'] }, status: :not_found
  end

  def destroy
    current_user.currencies.destroy(@currency.id)
  end

  private

  def check_currency
    @currency = current_user.currencies.find(params[:id])
    true
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Currency does not exist or does not belong to this user'] }, status: :not_found
    false
  end
end
