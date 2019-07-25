# grocer.rb 

def consolidate_cart(cart)
  # code here
c_Cart = Hash.new

result = cart.each do |item| 
    
    name = item.keys[0]
    count = item[name][:count]
      if (c_Cart[name])
       c_Cart[name][:count] +=1
      else
        c_Cart[name] = item[name]
        c_Cart[name][:count] = 1 
      end

end
return c_Cart
end


def apply_coupons(cart, coupons)
  # code 
  
=begin 
  ex. cart = {{
  "AVOCADO" => {:price => 3.00, :clearance => true, :count => 3},
  "KALE"    => {:price => 3.00, :clearance => false, :count => 1}
}}
keys = items; values= item details
=end
  
  coupons.each do |coupon|
  
    if cart.has_key?(coupon[:item]) 
      
      if cart[coupon[:item]][:count] >= coupon[:num]
        coupon_name = "#{coupon[:item]} W/COUPON"
        if cart[coupon_name]
          cart[coupon_name][:count] += coupon[:num]
        else
      
          cart[coupon_name] = {
           :price => (coupon[:cost] / coupon[:num]),
        
           :clearance => cart[coupon[:item]][:clearance],
        
           :count => coupon[:num]
      }
        end 
        cart[coupon[:item]][:count] -= coupon[:num]
      
     end
    end
  end
  cart
end



def apply_clearance(cart)
  # code here
  
  cart.each { |item| 
  
    details = item[1]
    
    
    if !!details[:clearance]
      details[:price] -= (details[:price]* 0.2).round(2)
    end
    
  }
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  
  cart.each do |item| 
    
    details = item[1]
  
  total += details[:price]*details[:count] 
  end

  
  if total > 100 
    total -= total* 0.10
  end
  
  return total
end
