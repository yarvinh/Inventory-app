class Brand < ActiveRecord::Base
    has_many :sneakers
    belongs_to :user

    def slug  
        name = self.name.downcase
        name.gsub(/\s/,'-')
     end
    
     def self.find_by_slug(user,slug)
       name =  slug.gsub("-"," ")  
       user.brands.select{|brand| brand.name.downcase == name }[0]   
     end


     def self.find_or_create_user_brand(user,name)
        user_brand = user.brands.select{|brand|brand.name.downcase == name.downcase.strip}
        if user_brand.empty?
            brand  = self.create(name: name)
            brand.user = user
            brand.save 
            brand
        else
            user_brand[0]
        end

    end

    def edit(user,params)
        brand_exist = user.brands.select{|brand|brand.name.downcase == params[:name].downcase.strip}
        params.each{|k,v| 
        if !v.strip.empty? && brand_exist.empty?
           self.send("#{k}=",v)
        end
       }
        self.save
     end




end