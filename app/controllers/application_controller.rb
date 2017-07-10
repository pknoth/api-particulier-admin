class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: "octo", password: "jesuissupersecret"
  protect_from_forgery with: :null_session
end
