class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #フォローするユーザーのid
  belongs_to :followed, class_name: "User" #フォローされるユーザーのid
end
