class UsersController < ApplicationController

    get '/users' do
      erb :'/users/index'
    end

    get '/signup' do
      erb :'/users/new'
    end

    get '/login' do
      erb :'/users/login'
    end

    get '/users/:id/show' do
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
    post '/login' do
      user = User.find_by(:username => params[:username])

        if user && !logged_in?
           if user.authenticate(params[:password]) && user.id != session[:id]
            session[:id] = user.id
            redirect "/users/#{user.id}/show"
          else
            redirect "/fail"
          end
        else
            redirect "/fail"
        end
    end

    post '/signup' do
      if params["username"] == "" || params["zipcode"] == "" || params["password"] == ""
        redirect '/signup'
      else
      @user = User.create(username: params["username"], zip_code: params["zipcode"], password: params["password"])
      @movie = Scraper.new(@user.zip_code)
      session[:id] = @user.id
      redirect "/movies/#{@user.id}/choosemovie"
      end
    end

end
