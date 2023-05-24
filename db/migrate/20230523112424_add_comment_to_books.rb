class AddCommentToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :comment, :text
  end
end
