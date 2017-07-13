require 'rack-flash'
class UsersController < ApplicationController
    enable :sessions
    use Rack::Flash

    get '/users' do
      erb :'/users/index'
    end

    get '/signup' do
      erb :'/users/new'
    end

    get '/login' do
      erb :'/users/login'
    end

    get '/users/:id' do
      if logged_in?
        @user = User.find(params[:id])
        erb :'/users/show'
      else
        redirect '/login'
      end
    end

    get '/logout' do
      session.clear
      redirect '/'
    end

    get '/fail' do
      erb :fail
    end

    get '/users/:id/edit' do
       @user = User.find(params[:id])
       erb :'/users/edit'
    end

    get '/users/delete/:id' do
        @user = User.find(params[:id])
        erb :'/users/delete'
    end

    post '/login' do
      user = User.find_by(:username => params[:username])

        if user && !logged_in?
           if user.authenticate(params[:password]) && user.id != session[:id]
            session[:id] = user.id
            redirect "/users/show/#{user.id}"
          else
            flash[:message] = "Failed Authentication"
            redirect "/login"
          end
        else
          flash[:message] = "Failed Authentication"
          redirect "/login"
        end
    end

    post '/signup' do
      if params["username"] == "" || params["zipcode"] == "" || params["password"] == ""
        redirect '/signup'
      else
      @user = User.create(username: params["username"], zip_code: params["zipcode"], password: params["password"])
      @movie = MovieScraper.new(@user.zip_code)
      @movie.doc
      session[:id] = @user.id
      redirect "/movies/choosemovie/#{@user.id}"
      end
    end

    patch '/users/edit/:id' do
      user = User.find(params[:id])
      user.username = params[:username]
      user.password = params[:password]
      user.save
      redirect '/'
    end

    delete '/users/delete/:id' do
      user = User.find(params[:id])
      user.delete
      session.clear
      redirect '/'
    end
end
