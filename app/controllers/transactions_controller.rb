class TransactionsController < ApplicationController
  before_action :account_belongs_to_user?, only: :create
  before_action :transaction_belongs_to_user?, except: %i[index create]

  def index
    @pagy, transactions = pagy(current_user.transactions)
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
    updated_transaction = transaction.update!(transaction_params)
    render json: updated_transaction, status: :ok
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
    params.require(:transaction).permit(:amount, :date, :category_id, :area_id, :destination_account_id, :destination_amount, :description)
  end

  def account_belongs_to_user?
    if account.nil?
      render json: { errors: ['Account does not exist'] }, status: :not_found
      return false
    end

    true
  end

  def account
    @account ||= current_user.accounts.find(params[:transaction][:account_id])
  end

  def transaction_belongs_to_user?
    if transaction.nil?
      render json: { errors: ['Transaction does not exist'] }, status: :not_found
      return false
    end

    true
  end

  def transaction
    @transaction ||= current_user.transactions.find(params[:id])
  end
end

