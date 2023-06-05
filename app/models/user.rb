class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  with_options presence: true do
   validates :name
   validates :email
 end

 # 自分がフォローされる（被フォロー）側の関係性
 # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
 # @user.booksのように、@user.yyyで、そのユーザがフォローしている人orフォローされている人の一覧を出したい
 # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

 #自分がフォローする側の可能性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
 #与フォローの関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed

# フォローしたときの処理
def follow(user)
  relationships.create(followed_id: user.id)
end
# フォローを外すときの処理
def unfollow(user)
  relationships.find_by(followed_id: user.id).destroy
end
def following?(user)
  followings.include?(user)
end

  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end