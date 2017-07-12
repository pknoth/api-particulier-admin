class ApplicationController < ActionController::Base
  before_action :authenticate!
  protect_from_forgery with: :null_session

  private

  def authenticate!
    if current_manager
      true
    else
      request_http_basic_authentication
    end
  end

  def current_manager
    @current_manager ||= authenticate_with_http_basic do |user, password|
      Manager.where(name: user).first&.authenticate(password)
    end
  end
end
