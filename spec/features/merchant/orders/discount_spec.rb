# require 'rails_helper'
#
# describe "As a  merchant on the order show page" do
#   before :each do
#     @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zb0y@hotmail.com", password: "sfgdfg", role: 0)
#     @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
#     @user2 = @mike.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy1233@hotmail.com", password: "sfgdfg", role: 1)
#     @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
#     @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
#     @item_order_1 = @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
#     visit "/merchant/orders/#{@order_1.id}"
#   end
#
#   it "can click on a link to a new page to manage discounts" do
#     visit "/merchant"
#     click_on "Manage Bulk Discounts"
#     expect(current_path).to eq("/merchant/discounts")
#   end
# end
