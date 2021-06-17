class CurrenciesController < ApplicationController
  before_action :check_currency, except: :index

  def index
    render json: Currency.all
  end

  def show
    render json: @currency, include: [:selling_rates, :purchase_rates]
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
