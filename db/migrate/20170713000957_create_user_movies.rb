class CreateUserMovies < ActiveRecord::Migration
  def up
   create_table :user_movies do |t|
       t.integer :user_id
       t.integer :movie_id
   end
  end

  def down
   drop_table :user_movies
  end
end
