class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

   rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to root_path, alert: exception.message }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end
  
protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def authenticate_admin_user! #use predefined method name
    redirect_to '/' and return if user_signed_in? && !current_user.is_admin? 
    authenticate_user! 
  end 
  def current_admin_user #use predefined method name
    return nil if user_signed_in? && !current_user.is_admin? 
    current_user 
  end 
end
