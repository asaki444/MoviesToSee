require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "moviesareawesome"
  end


  get '/' do
    erb :index
    #welcome to MoviesToSee!!!
  end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:id])
    end


end
