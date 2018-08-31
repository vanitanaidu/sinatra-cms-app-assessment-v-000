require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :"users/home"
  end

  helpers do

      def current_user
        @current_user ||= User.find_by(id: session[:user_id])
      end

      def logged_in?
        !!current_user
      end

  end

end
