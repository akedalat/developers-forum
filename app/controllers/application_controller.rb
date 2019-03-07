class ApplicationController < ActionController::Base
  before_action :authorized
  skip_before_action :authorized, only: [:index, :new, :created]

  #before_action :admin_authorized, only: [:edit, :destroy]

helper_method :logged_in?, :current_user, :authorized, :admin, :admin_authorized

  def current_user
    if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
    else
      @current_user
    end
  end

  def admin
    @admin = current_user
    if @admin.email ==  "akedalat@gmail.com"
      return @admin
    end
  end

  def admin_authorized
    !!admin
  end

  def logged_in?
   !!current_user
  end

  def authorized
    return head(:forbidden) unless logged_in?
  end

end
