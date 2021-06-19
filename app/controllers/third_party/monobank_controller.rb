module ThirdParty
  class MonobankController < ApplicationController
    def index
      render json: {}, status: :ok and return if account.nil? or Transaction.find_by_monobank_id(params[:data][:statementItem][:id]).present?

      description = params[:data][:statementItem][:description]
      description += ": #{params[:data][:statementItem][:comment]}" unless params[:data][:statementItem][:comment].empty?
      transaction = Transaction.new({
                                      amount: params[:data][:statementItem][:operationAmount] / 100.0,
                                      date: Time.at(params[:data][:statementItem][:time]).to_date,
                                      area: account.user.areas.first,
                                      category: account.user.categories.first,
                                      description: description,
                                      monobank_id: params[:data][:statementItem][:id]
                                    })
      account.transactions << transaction
      account.save
      render json: {}, status: :ok
    end

    def account
      @account ||= Account.find_by_monobank_id(params[:data][:account][:id])
    end
  end
end
