class TransactionsController < ApplicationController
  def index
    @transactions = current_user&.transactions
  end

  def new
  end

  def show
    @transaction = current_user&.transactions.find(params[:id])
  end

  def edit
  end
end
