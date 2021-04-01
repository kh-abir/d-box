class AddCouponDiscountToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :coupon_discount, :decimal, default: 0.0
  end
end
