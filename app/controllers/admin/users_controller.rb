class Admin::UsersController < ApplicationController
  def show
     @user = User.find(params[:id])
     @books = @user.books
  end


 def index
   @users = User.all
 end

  private

  def user_params
    params.require(:user).permit(:name, :email, :introduction)
  end

end
