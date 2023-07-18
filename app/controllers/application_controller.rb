class ApplicationController < ActionController::Base
  layout :set_layouts
  before_action :configure_permitted_parameters, if: :devise_controller?


  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role_id, :email])
    end

    def after_sign_in_path_for(resource)
      if resource.is_admin
        root_path
      else
        root_path
      end
    end


    def set_layouts
      if current_user && current_user.is_admin
        return 'admin'
      else
        return 'application'
      end
    end

end
