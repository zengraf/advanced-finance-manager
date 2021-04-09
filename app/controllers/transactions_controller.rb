class TransactionsController < ApplicationController
  before_action :check_transaction, except: %i[index new create]

  def index
    @transactions = current_user.transactions
    render json: @transactions
  end

  def new
    @transaction = current_user.transactions.build
  end

  def create
    account = current_user.accounts.find(params[:transaction][:account_id])
    if account.nil?
      flash[:danger] = 'Account does not exist or does not belong to user'
      redirect_to transactions_path
      return
    end

    account.transactions.create(transaction_params)
    redirect_to transactions_path
  end

  def show; end

  def edit; end

  def update
    @transaction.update(transaction_params)
    redirect_to transactions_path
  end

  def destroy
    @transaction.destroy
    redirect_to transactions_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :date, :category_id, :area_id)
  end

  def check_transaction
    @transaction = Transaction.find(params[:id])
    if @transaction.nil?
      flash[:warning] = 'Transaction does not exist'
      redirect_to transactions_path
      return
    end

    account = current_user.accounts.find(@transaction.account.id)
    if account.nil?
      flash[:danger] = 'Account does not exist or does not belong to user'
      redirect_to transactions_path
      return
    end

    true
  end
end

