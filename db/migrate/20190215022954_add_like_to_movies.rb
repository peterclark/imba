class AddLikeToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :like, :boolean
  end
end
