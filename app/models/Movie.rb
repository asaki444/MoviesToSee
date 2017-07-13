class Movie < ActiveRecord::Base
  has_many :user_movies
  has_many :users, through: :user_movies
  validates :name, uniqueness: true


end
