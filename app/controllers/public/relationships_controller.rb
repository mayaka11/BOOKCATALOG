class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    # params[:user_id]これはリンクから送られてきたuser_idをparamsで受け取っている
    # そして受け取った値をモデルのメソッドに受け渡している
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  # フォローフォロワー一覧処理
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
