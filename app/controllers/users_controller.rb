class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.html {
          flash[:success] = "User account created!"
          redirect_to :back
        }
        format.js { }
      end
    else
      render :new
    else
  end

  private

  def user_params
    params.require(:user).permit(:username, :avatar, :email, :bio, :password, :password_confirmation)
  end

end