class AccountsController < ApplicationController
  before_action :check_account, except: %i[index new create]

  def index
    @accounts = current_user.accounts
  end

  def new
    @account = current_user.accounts.build
  end

  def create
    @account = current_user.accounts.create(account_params)
    redirect_to @account
  end

  def show; end

  def edit; end

  def update
    @account.update(account_params_update)
    redirect_to @account
  end

  def destroy
    @account.destroy
    redirect_to accounts_path
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
    if @account.nil?
      flash[:danger] = 'Account does not exist or does not belong to user'
      redirect_to transactions_path
      return
    end

    true
  end
end
