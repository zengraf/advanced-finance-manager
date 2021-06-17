class AccountsController < ApplicationController
  before_action :check_account, except: %i[index summary create]

  def index
    accounts = current_user.accounts
    render json: accounts
  end

  def summary
    if params[:currency_id]
      currency = Currency.find(params[:currency_id])
    else
      currency = current_user.currencies.first || Currency.first
    end
    totals = current_user.accounts.includes(:currency).group(:currency).sum(:amount)

    render json: {
      totals: totals.map { |c, t| { currency: c, value: t } },
      grand_total: {
        currency: currency,
        value: totals.inject(0) { |sum, total| sum + total.last * (total.first.selling_rates.where(to: currency).first&.rate || 1) }
      }
    }
  end

  def create
    account = current_user.accounts.create!(account_params)
    render json: account, status: :created
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def show
    render json: @account
  end

  def update
    @account.update!(account_params_update)
    render json: @account, status: :accepted
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def destroy
    @account.destroy!
    render json: {}, status: :no_content
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  private

  def account_params
    params.require(:account).permit(:name, :amount, :currency_id)
  end

  def account_params_update
    params.require(:account).permit(:name, :amount)
  end

  def check_account
    @account = current_user.accounts.find(params[:id])
    true
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Account does not exist or does not belong to user'] }, status: :not_found
    return false
  end
end