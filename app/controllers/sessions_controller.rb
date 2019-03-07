class SessionsController < ApplicationController
  before_action :authorized
  skip_before_action :authorized, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
    
      redirect_to user_path(@user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render "new"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to "/"
  end

end
