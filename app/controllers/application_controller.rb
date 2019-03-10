class ApplicationController < ActionController::Base

  helper_method :logged_in?, :current_user, :authorized, :admin, :admin_authorized, :current_user_authorized

  def current_user
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end

  def admin
    if !current_user.nil?
      if current_user.email ==  "akedalat@gmail.com"
        return true
      end
    else
      return false
    end
  end

  def admin_authorized
    return head(:forbidden) unless admin
  end

  def current_user_authorized
    return head(:forbidden) unless current_user
  end

  def logged_in?
   !!current_user
  end

  def authorized
    return head(:forbidden) unless logged_in?
  end

end
