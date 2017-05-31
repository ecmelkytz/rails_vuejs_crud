class AddLikeCountToBook < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :like_count, :integer, default: 0
  end
end
