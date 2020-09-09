
require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    use Rack::Flash
  end
   
  get "/myaccount" do
      if session[:user_id] == nil
          redirect '/business/login'
      else
          redirect "/business"
      end
  end
  
  get "/" do 
      erb :index
  end


end