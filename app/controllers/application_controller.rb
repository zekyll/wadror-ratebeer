class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # methods available in views
  helper_method :current_user

  def current_user
    return nil if session[:user_id].nil?
    user = User.find_by(id: session[:user_id]);
    if user == nil
      session[:user_id] = nil
    end
    return user
  end

  def ensure_that_signed_in
    redirect_to signin_path, notice:'Sign-in required.' unless current_user
  end

  def ensure_that_signed_in_as_admin
    redirect_to signin_path, notice:'Admin rights required.' unless current_user and current_user.admin
  end
end
