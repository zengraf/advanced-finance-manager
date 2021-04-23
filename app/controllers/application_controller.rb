class ApplicationController < ActionController::API
  include Pagy::Backend
  include ActionController::MimeResponds

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action { pagy_headers_merge(@pagy) if @pagy }

  respond_to :json

  def bad_request_error(exception)
    render json: { errors: exception.record.errors }, status: :bad_request
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
