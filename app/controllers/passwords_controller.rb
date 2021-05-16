require 'securerandom'

class PasswordsController < Devise::PasswordsController

  def update
    super do |resource|
      if resource.errors.empty?
        resource.update_column(:jti, SecureRandom.uuid)
      end
    end
  end

end
