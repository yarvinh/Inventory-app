class BusinessUsersController < ApplicationController


# ********************
   get '/business/signup' do
      erb :"business/signup"
   end
# Has a error message 
   post '/business/signup' do     
      it_did = User.find_or_create_user(params[:user])
      if it_did.class != String
         session[:user_id] = it_did.id
         redirect '/business'
      else
         @massage  = it_did
         erb :'business/signup'
      end
   end 
# ******************
   get "/business" do
      if session[:user_id] == nil
         redirect "/"
      else
         @user = User.find_by(id: session[:user_id])
         erb :"business/index"
      end
   end
#*******************
   get '/business/login' do 
       erb :'business/login'
   end

# has a error message 
   post '/business/login' do
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         redirect "/business"
      elsif  params[:username].strip.empty?
         flash[:notice] = "No username was entered."

         redirect:'/business/login'
      elsif params[:password].strip.empty?
         flash[:notice] = "No password was entered."
         erb :'business/login'
      else
         flash[:notice]="Invalid username or password."
         erb :'business/login'
      end
   end
 
#******************
   get '/business/signout' do
      session.clear
      redirect "/"
    end
#*****************
    get '/business/user-info' do
      if session[:user_id] != nil
         @user = User.find_by(id: session[:user_id])
         erb :'business/user_info'
      else
         redirect "/"
      end   
    end
# ****************
    get '/business/edit-user' do
      if session[:user_id] != nil
         @user = User.find_by(id: session[:user_id])
         erb :"business/edit"
      else
         redirect "/"
      end
    end
# ****************
    patch '/business/:id/edit' do
      @user = User.find_by(id: params[:id]) 
      if params[:user][:email]  == params[:email] && params[:user][:username] == nil
         @user.edit(params[:user])
      elsif params[:user][:username]  == params[:username] && params[:user][:email] == nil
         @user.edit(params[:user])
      elsif params[:user][:name] != nil
         @user.edit(params[:user])
      end
      # @user.update(params[:user])
       redirect '/business/edit-user'
    end
#****************
    delete '/business/:id' do
      user = User.find_by(id: params[:id])
      user.sneakers.each{|sneaker| sneaker.delete}
      user.brands.each{|brand| brand.delete} 
      session.clear
      user.delete
      redirect "/"
    end
#******************   
   get '/business/password' do
      if session[:user_id] != nil
         @user = User.find(session[:user_id])
         erb :'business/password'
      else
         redirect "/"
      end
   end
#Has a error message
   post '/business/password' do
      @user = User.find(session[:user_id])
      if @user.authenticate(params[:old][:password]) && params[:new][:password] == params[:password] && params[:new][:password].size > 7
         @user.password = params[:new][:password]
         @user.save
         redirect '/business/signout'
      else
         @message = "Passwords do not match, or password has less than 8 characters "
         erb :'business/password'
      end     
   end




end