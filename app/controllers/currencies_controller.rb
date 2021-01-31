class CurrenciesController < ApplicationController
  def index
    @currencies = current_user&.currencies
  end

  def show
    @currency = Currency.find(params[:id])
    @purchase_rates = CurrencyRate.where(to_id: params[:id], from: current_user.currencies).includes(:from).order(from_id: :asc)
    @selling_rates = CurrencyRate.where(from_id: params[:id], to: current_user.currencies).includes(:to).order(to_id: :asc)
  end

  def new; end

  def create
    current_user.currencies << Currency.find(params[:currency_id])
    redirect_to currencies_path
  end

  def destroy
    current_user.currencies.delete(Currency.find(params[:id]))
    redirect_to currencies_path
  end
end
