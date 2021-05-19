require 'securerandom'

class PasswordsController < Devise::PasswordsController

  def update
    super do |resource|
      if resource.errors.empty?
        User.revoke_jwt(nil, resource)
      end
    end
  end

end
