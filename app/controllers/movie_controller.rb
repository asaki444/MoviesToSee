require 'pry'
class MoviesController < ApplicationController
  #
  # GET /movies list of movies
  # GET /movies/:id individual movie
  # GET /movies/new a form to create a movie -> POST /movies create a movie
  # GET /movies/:id/edit a form to update movie information -> PUT(Patch) /movies update a movie
  # DELETE /movies/:id
  # GET /users/:id/movies
  # POST /users/:id/movies

  get '/movies' do
    @movies = Movie.all
    erb :'/movies/index'
  end

  post '/users/:id/movies' do
    @movies = Movie.find(params["movie_ids"])
    @movies.each do  |movie|
      if !current_user.movies.include?(movie)
        current_user.movies << movie
      end
      # if the movie is already in the current users movie collection ignore it
      # if the movie is not part of the current_users movie collection push it into the collection
    end
    redirect to "/users/#{current_user.id}"
    # add movies to the current users movies collection
  end

  # get '/movies/#{current_user.id}' do
  #   if current_user.movies.empty?
  #     redirect "/movies/#{current_user.id}"
  #   else
  #     erb :'/movies/edit'
  #   end
  #
  # end

  post '/movies/:#{current_user.id}' do
    @movies = Movie.find(params["movie_ids"])
    current_user.movies = @movies
    @user.save
    redirect "/users/#{current_user.id}"
  end

  patch '/movies/#{current_user.id}/edit' do
    if logged_in?
    @movies = Movie.find(params["movie_ids"])
    current_user.movies = @movies
    current_user.save
    redirect "/users/show/#{current_user.id}"
    else
    redirect '/'
    end
  end

end
