class ApplicationController < ActionController::Base

before_action :configure_permitted_parameters, if: :devise_controller?

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # ログアウト後のリダイレクト先
  def
    after_sign_out_path_for(resource)
    if resource == :user
       root_path
    elsif resource == :admin
       new_admin_session_path
    else
       root_path
    end
  end

end
