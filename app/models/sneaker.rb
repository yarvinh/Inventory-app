class Sneaker < ActiveRecord::Base
    belongs_to :brand

      def edit(params)
         params.each{|k,v| 
         if !v.strip.empty?
            self.send("#{k}=",v)
         end
        }
         self.save
      end
    # if it do not find or create, display a message.
      def self.find_or_create_sneaker(brand,sneaker)
       empty_inputs = sneaker.map {|k,v| v.strip.empty?}
        sneakers = brand.sneakers.select{|s| s.bar_code == sneaker["bar_code"].strip}
        if sneakers.empty? && !empty_inputs.include?(true)
            sneaker = self.create(sneaker)
            sneaker.brand = brand
            sneaker.save
            sneaker
        elsif empty_inputs.include?(true)
            "Empty Input. Check for empty input"
        else
            sneakers[0]
        end
      end


end