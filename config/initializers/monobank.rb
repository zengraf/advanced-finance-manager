require "monobank_api"

Rails.configuration.after_initialize do
  if defined?(Rails::Server)
    User.where.not(monobank_token: nil).find_each do |user|
      MonobankApi.webhook(user)
    end
  end
end
