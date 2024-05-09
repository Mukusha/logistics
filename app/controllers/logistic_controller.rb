class LogisticController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def save
    @user = User.new(user_params)
    if @user.save
      redirect_to :root
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name,:father_name, :phone,:email)
  end
end
