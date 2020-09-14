class User < ActiveRecord::Base
    has_secure_password
    has_many :brands
    has_many :sneakers, through: :brands

    validates :username, presence: true
    validates :password_digest, :email, presence: true
    validates :email, uniqueness: true

    def edit(params)  
        user = User.all.select {|user| 
            if params[:user][:username] != nil 
                user.username.downcase == params[:user][:username].downcase 
            elsif params[:user][:email] != nil
                user.email.downcase == params[:user][:email]
            end
        } 

        message = ""
      
        params[:user].each{|k,v| 
            if  !v.strip.empty? && user.empty? 
                if params[:user][:name] != nil 
                   self.send("#{k}=",v.strip)
                   message = "#{k.to_s.capitalize} Edited"
                elsif v.strip == params[:username]
                   self.send("#{k}=",v.strip)
                   message = "#{k.to_s.capitalize} Edited"
                elsif v.strip == params[:email]
                   self.send("#{k}=",v.strip)
                   message = "#{k.to_s.capitalize} Edited"
                else
                    message = "Fail to confirm #{k.to_s}"
                end
                self.save
            elsif v.strip.empty?
                message = "Please enter your #{k.to_s}"
            elsif !user.empty?
                message = "#{k.to_s.capitalize} is already register"
            end
        }
        message
      
    end


     def self.find_or_create_user(params)
        not_empty = []
        user_info = []
        params.each{|k,v| 
           not_empty << !v.strip.empty?
           user_info << k.to_s.capitalize
        }  
        user = self.all.select{|user| user.username.downcase == params[:username].downcase || user.email.downcase == params[:email].downcase }
        if user.empty? && !not_empty.include?(false) && params[:password].size > 7 
            user = self.create(params)
            user  
        elsif not_empty.include?(false)
            index = not_empty.index(false)
            "Please enter your #{user_info[index]}."
        elsif !user.empty?
            "User already exist"
        elsif params[:password].size < 8
            "Password must be 8 or more characters" 
        end
       
       end
end