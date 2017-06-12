class MoviesController < ApplicationController

  get '/movies/:id/choosemovie' do
    @user = User.find(params[:id])
    erb :'/movies/choosemovie'
  end

  get '/movies/:id/edit' do
    @user = User.find(session[:id])
    erb :'/movies/edit'
  end

  post '/movies/:id/choosemovie' do
    @user = User.find(params[:id])
    @movies = Movie.find(params["movie_ids"])
    @user.movies = @movies
    @user.save
    redirect "/users/#{@user.id}/show"
  end

  post 'movies/edit/:id' do
    if loggedin?
    @user = User.find(params[:id])
    @movies = Movie.find(params["movie_ids"])
    @movies.doc
    @user.movies = @movies
    @user.save
    redirect "/users/#{@user.id}/show"
    else
    redirect '/'
    end
  end

end
