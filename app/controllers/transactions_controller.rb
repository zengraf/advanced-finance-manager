class TransactionsController < ApplicationController
  before_action :check_account, only: :create
  before_action :check_transaction, except: %i[index create]

  def index
    transactions = current_user.transactions.eager_load(category: [], area: [], account: [:currency]).order(date: :asc)
    transactions = transactions.reorder(params[:sort_by] => params[:direction] || :asc, date: :asc) if params[:sort_by]

    @pagy, transactions = pagy(transactions)
    render json: transactions
  end

  def create
    created_transaction = account.transactions.create!(transaction_params)
    render json: created_transaction, status: :created
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def show
    render json: transaction, status: :ok
  end

  def update
    transaction.update!(transaction_params)
    render json: transaction, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  def destroy
    transaction.destroy!
    render status: :no_content
  rescue ActiveRecord::RecordInvalid => e
    bad_request_error(e)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :date, :account_id, :category_id, :area_id, :destination_account_id, :destination_amount, :description)
  end

  def transaction
    @transaction ||= current_user.transactions.find(params[:id])
  end

  def check_transaction
    transaction
    true
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Transaction does not exist'] }, status: :not_found
    false
  end

  def account
    @account ||= current_user.accounts.find(params[:transaction][:account_id])
  end

  def check_account
    account
    true
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Account does not exist'] }, status: :not_found
    return false
  end
end

