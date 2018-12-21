require "pry"


def consolidate_cart(cart)
  new_cart = {}
  count_cart = Hash.new 0

  cart.each do |list_item|
    list_item.each do |item, description_hash|
        count_cart[item] += 1
      description_hash.each do |key, value|
        new_cart[item] = description_hash
      end
    end
  end

  new_cart.each do |item, description_hash|
    count_cart.each do |key, value|
      if item == key
        new_cart[item][:count] = value
      end
    end
  end

new_cart
end

# cart = {
#   "AVOCADO" => {:price => 3.0, :clearance => true, :count => 3},
#   "KALE"    => {:price => 3.0, :clearance => false, :count => 1}
# }
#
# coupons = {:item => "AVOCADO", :num => 2, :cost => 5.0}



def apply_coupons(cart, coupons)
coupon_cart = {}
item_count = 0
coupon_count = 0
sale_price = 0
clearance_status = false

cart.each do |item, item_hash|
  item_hash.each do |key, value|
    if key == :count
      item_count = value
    end

    if key == :clearance
      clearance_status = value
    end

    coupons.each do |ckey, cvalue|

      if ckey == :num
        coupon_count = cvalue
      end

      if ckey ==:cost
        sale_price = cvalue
      end

      if cvalue == item && item_count >= 1 && coupon_count >= 1
        coupon_cart["#{item} W/COUPON"] = {:price => sale_price,
          :clearance => clearance_status, :count => (item_count/coupon_count).round}
        coupon_cart[item] = item_hash
        coupon_cart[item][:count] = (item_count % coupon_count)
      else
        coupon_cart[item] = item_hash
      end
    end
  end
end
coupon_cart
end


# def apply_coupons(cart, coupons)
#   return {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>1}, "AVOCADO W/COUPON"=>{:price=>5.0, :clearance=>true, :count=>1}, "KALE"=>{:price=>3.0, :clearance=>false, :count=>1}}
#
# end

# apply_coupons(cart, coupons)


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
