class TransactionsController < ApplicationController
  def index
    @transactions = Transaction.all
  end

  def new
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def edit
  end
end
