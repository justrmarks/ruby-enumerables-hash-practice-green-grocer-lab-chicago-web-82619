# grocer.rb 

def consolidate_cart(cart)
  # code here
c_Cart = Hash.new

result = cart.reduce(c_Cart) do |memo, item| 
    
    name = item.keys[0]
    count = item[name][:count]
    #  if (!!memo[name])
    #   memo[name][:count] +=1
    #  else
        memo[name] = item[name]
        memo[name][:count] = 1 
    #  end

end
return result
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
  
    if cart.has_key?(coupon[:item]) && cart[coupon[:item]][:count] >= coupon[:num]
      
      then
      
      cart["#{:item} W/COUPON"] = {
        :price => (coupon[:cost] / coupon[:num]),
        
        :clearance => cart[:item][:clearance],
        :count => coupon[:num]
      }
      
      cart[coupon[:item]] -= coupon[:num]
      
    end
      
    if [cart[coupon[:item]]] < 1
        cart.delete(coupon[:item])
    end
      
    
    
  end
  
end



def apply_clearance(cart)
  # code here
  
  cart.each_key { |item| 
    
    if item[:clearance]
      item[:price] -= (item[:price]* 0.2).round(2)
    end
    
  }
end

def checkout(cart, coupons)
  # code here
  total = 0
  
  consolidate_cart(cart)
  apply_coupons(cart,coupons)
  apply_clearance(cart)
  
  cart.each_key do |item| 
  
  total+= item[:price]*item[:count] 
  end

  
  if total > 100 
    total -= total* 0.10
  end
  
  return total
end
