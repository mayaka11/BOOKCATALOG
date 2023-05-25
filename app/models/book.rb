class Book < ApplicationRecord

  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy


  validates :title, presence: true
  validates :author, presence: true

  has_many :book_tags, dependent: :destroy
  has_many :tags, through: :book_tags, dependent: :destroy

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
