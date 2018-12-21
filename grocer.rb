require "pry"



def consolidate_cart(cart)
  cart.each_with_object({}) do |item, new_hash|
    item.each do |name, details|
      if new_hash[name]
        details[:count] += 1
      else
        details[:count] = 1
        new_hash[name] = details
      end
    end
  end
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
  name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end



def apply_clearance(cart)
  cart.each do |item, details|
    if cart[item][:clearance]
      new_price = (cart[item][:price] *= 0.8).round(2)
      cart[item][:price] = new_price
    end
  end
end



def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated_cart, coupons)
  clearance_applied = apply_clearance(coupons_applied)

  cart_total = 0

  clearance_applied.each do |item, details|
    cart_total += details[:price] * details[:count]
  end

  if cart_total > 100
    cart_total = cart_total * 0.9
  end
  cart_total
end
