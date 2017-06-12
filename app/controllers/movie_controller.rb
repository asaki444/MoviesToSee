require 'pry'
class MoviesController < ApplicationController

  get '/movies/choosemovie/:id' do
    @user = User.find(params[:id])
    erb :'/movies/choosemovie'
  end

  get '/movies/edit/:id' do
    @user = User.find(session[:id])
    if @user.movies.empty?
      redirect "/movies/choosemovie/#{@user.id}"
    else
      erb :'/movies/edit'
    end

  end

  post '/movies/choosemovie/:id' do
    @user = User.find(params[:id])
    @movies = Movie.find(params["movie_ids"])
    @user.movies = @movies
    @user.save
    redirect "/users/show/#{@user.id}"
  end

  post 'movies/edit/:id' do
    if loggedin?
    @user = User.find(params[:id])
    @movies = Movie.find(params["movie_ids"])
    @movies.doc
    @user.movies = @movies/
    @user.save
    redirect "/users/show/#{@user.id}"
    else
    redirect '/'
    end
  end

end
