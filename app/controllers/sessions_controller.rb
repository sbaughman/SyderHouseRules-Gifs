class SessionsController < ApplicationController
  before_action :prohibit_user, only: [:new, :create]
  before_action :require_user, only: [:destroy]

  def new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.username
      respond_to do |format|
        format.html {
          flash[:success] = "You're logged in. Happy Giffing!"
          redirect_to :root
        }
        format.js { }
      end
    else
      flash[:danger] = "That username/password combo is incorrect. Try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html {
        flash[:success] = "Logged out successfully"
        redirect_to :root
      }
      format.js { }
    end
  end

end
