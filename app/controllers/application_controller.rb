class ApplicationController < ActionController::Base
  layout :set_layouts
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role_id, :email])
    end

end
