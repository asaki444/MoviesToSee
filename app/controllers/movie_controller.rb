class MoviesController < ApplicationController
  get '/movies/:id/choosemovie' do
    @user = User.find(params[:id])
    erb :'/movies/choosemovie'
  end

  post '/movies/:id/choosemovie' do
    @user = User.find(params[:id])
    binding.pry
  end
end
