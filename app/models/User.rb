class User < ActiveRecord::Base
  has_secure_password
  has_many :user_movies
  has_many :user, through: :user_movies
end
