class BrandsController  < ApplicationController


 #******************
   post "/brand/new" do
      user = User.find_by(id: session[:user_id]) 
      name = params[:name].strip
      if !name.empty?
         @brand = Brand.find_or_create_user_brand(user,name)
      end
      redirect "/business"
   end

#******************
    get '/brand/:slug' do  
        user = User.find(session[:user_id])
        if session[:user_id] == nil
            redirect "/"
        else
            @brand = Brand.find_by_slug(user,params[:slug]) 
            erb :'brands/brand'
        end
    end


#********************
    post '/brand/delete' do
        if params[:brand_ids] != nil 
            params[:brand_ids].each {|id| 
                brand = Brand.find_by(id: id)
                brand.sneakers.each{|sneaker|sneaker.delete}
                brand.delete
            }     
        end
         redirect "/business"
    end

#****************************
    get '/brand/:id/edit' do
        @user = User.find(session[:user_id])
        @brand = @user.brands.select{|b| b.id.to_i == params[:id].to_i}[0]
       erb :'brands/edit'
    end
#**************************
    patch '/brand/:id' do
        @user = User.find(session[:user_id])
        @brand = @user.brands.select{|b| b.id.to_i == params[:id].to_i}[0]
        @brand.edit(@user,params[:brand])
        redirect "/brand/#{@brand.slug}"
    end
end