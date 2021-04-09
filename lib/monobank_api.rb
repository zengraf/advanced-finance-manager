class MonobankApi
  ENDPOINT = 'https://api.monobank.ua'

  class << self
    def currency
      HTTP.get("#{ENDPOINT}/bank/currency")
          .parse
    end

    def client_info(user)
      client(user).get("#{ENDPOINT}/personal/client-info")
                  .parse
    end

    private

    def client(user)
      HTTP.headers('X-Token' => user.monobank_token)
    end
  end
end