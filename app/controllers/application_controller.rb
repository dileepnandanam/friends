class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def connections_for(user)
  	connections = (
      user.responses.where(accepted: true).map(&:responce_user) +
      user.posted_responses.where(accepted: true, group_id: nil).map(&:user)
    ).uniq
  end

  protected

    def check_user
      unless current_user
        redirect_to root_path and return
      end
    end

    def authenticate_user!
      unless current_user.present?
        session[:after_sign_in_path] = request.url
        redirect_to new_user_session_path
      end
    end

    def after_sign_in_path_for(resource)
      if session[:after_sign_in_path]
        session.delete(:after_sign_in_path)
      else
        connections_users_path
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :image, :name, :gender])
    end
end
