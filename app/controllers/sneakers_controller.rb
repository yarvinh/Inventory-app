class SneakersController < ApplicationController
    
#********************
    get "/sneaker/new" do 
        user = User.find_by(id: session[:user_id])
        if session[:user_id] == nil
           redirect "business/login"
        else
        @brands = user.brands
        erb :'sneakers/new'
        end
     end
   
#Has error message.
    post "/sneaker/new" do   
        user = User.find_by(id: session[:user_id])
        @brands = user.brands
        if !params[:name].strip.empty?
            @brand = Brand.find_or_create_user_brand(user,params[:name].strip)
            error_or_sneaker_intance = Sneaker.find_or_create_sneaker(@brand,params[:sneaker]) 
            if error_or_sneaker_intance .class == String
                @message_1 = error_or_sneaker_intance 
                erb :"sneakers/new"  
            else 
                redirect "/brand/#{@brand.slug}"
            end
        elsif params[:brand_id] != nil
            @brand = Brand.find_by(id: params[:brand_id])
            error_or_sneaker_intance = Sneaker.find_or_create_sneaker(@brand,params[:sneaker]) 
            if error_or_sneaker_intance .class == String
                @message_1 = error_or_sneaker_intance 
                erb :"sneakers/new"  
            else 
                redirect "/brand/#{@brand.slug}"
            end
        else
            @message_2 = "No brand was selected. Please Select or create a new brand."
            erb :"sneakers/new"
        end
    end
    
#*********************
    post '/sneaker/:slug/search' do
        user = User.find(session[:user_id])
        @brand = Brand.find_by_slug(user,params[:slug])
        @sneaker = @brand.sneakers.select{|sneaker| 
            sneaker.style.downcase.include?(params[:search].downcase.strip) || sneaker.bar_code == params[:search].strip
        }
        if @sneaker.size > 1
            erb :'sneakers/sneakers'
        elsif @sneaker.size == 1
            redirect "/sneaker/#{@sneaker[0].id}"
        else
            redirect "/brand/#{params[:slug]}" 
        end     
    end
#*********************
    get '/sneaker/:id' do
        @sneaker = Sneaker.find_by(id: params[:id])
        @brand = @sneaker.brand
        erb :'sneakers/sneaker'
    end


#**********************
    post '/sneaker/:slug/delete' do
        if params[:sneaker_ids] != nil
            params[:sneaker_ids].each {|id| Sneaker.find_by(id: id).delete}     
        end
        redirect "/brand/#{params[:slug]}"
    end

#***********************
      get '/sneaker/:id/edit' do
        if session[:user_id] != nil
            user = User.find_by(id: session[:user_id])
            @sneaker = Sneaker.find_by(id: params[:id])
            @brand = @sneaker.brand
            @brands = user.brands
            erb :"sneakers/edit"
        else
            redirect "/"
        end
      end
#*********************
    patch '/sneaker/:id' do
        user = User.find_by(id: session[:user_id])
        @sneaker = user.sneakers.select {|sneaker| sneaker.id == params[:id].to_i}[0]
        @sneaker.edit(params[:sneaker])
        brand = Brand.find_by(id: params[:brand_id])
       if params[:name].strip.empty?
           @sneaker.brand = brand
           @sneaker.save
       else
          brand = Brand.find_or_create_user_brand(user,params[:name])
          @sneaker.brand = brand
          @sneaker.save
          brand.user = user
          brand.save
       end 
        redirect "sneaker/#{@sneaker.id}" 
    end
#*****************************
    post '/sneaker/:id/add' do
        user = User.find(session[:user_id])
        @sneaker = user.sneakers.select {|sneaker| sneaker.id == params[:id].to_i}[0]
        if !params[:quantity].strip.empty? 
            @sneaker.quantity += params[:quantity].to_i
            @sneaker.save
        end
        redirect "/sneaker/#{@sneaker.id}" 
    end
#****************************
    post '/sneaker/:id/subtract' do
        user = User.find(session[:user_id])
        @sneaker = user.sneakers.select {|sneaker| sneaker.id == params[:id].to_i}[0]
        if !params[:quantity].strip.empty? 
            @sneaker.quantity -= params[:quantity].to_i
            @sneaker.save
        end
        redirect "/sneaker/#{@sneaker.id}"    
    end

end