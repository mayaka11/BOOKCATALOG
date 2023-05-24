class Public::UsersController < ApplicationController
  before_action :set_user, only: [:likes]

  def show
     @user = User.find(params[:id])
     @books = @user.books
  end


  def edit
     @user = User.find(params[:id])
  end


  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end


  def favorites
    @book = Book.find(params[:id])

    favorites = Favorite.where(user_id: current_user.id).pluck(:book_id)
    @favorite_books = Book.find(favorites)
  end


  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
