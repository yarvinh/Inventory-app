class User < ActiveRecord::Base
    has_secure_password
    has_many :brands
    has_many :sneakers, through: :brands

    validates :username, presence: true
    validates :password_digest, :email, presence: true
    validates :email, uniqueness: true

    def edit(params)
        params.each{|k,v| 
        if !v.strip.empty?
           self.send("#{k}=",v)
        end
       }
        self.save
     end


     def self.find_or_create_user(params)
        not_empty = []
        params.each{|k,v| not_empty << !v.strip.empty?}  
        user = self.all.select{|user| user.username.downcase == params[:username].downcase || user.email.downcase == params[:email].downcase }
        if user.empty? && !not_empty.include?(false) && params[:password].size > 7 
            user = self.create(params)
            user  
        elsif not_empty.include?(false)
            "Empty input. Enter user name and password."
        elsif !user.empty?
            "User already exist."
        elsif params[:password].size < 8
            "password must be 8 or more characters." 
        end
       
       end
end