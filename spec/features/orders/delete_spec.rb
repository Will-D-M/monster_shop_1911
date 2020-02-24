require 'rails_helper'

describe "Cancel an existing order" do
  before :each do
    @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)

    visit '/'
    click_on "Log In"
    fill_in "Email", with: "zboy@hotmail.com"
    fill_in "Password", with: "sfgdfg"
    click_on "Login"

    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    @item_order_1 = @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
  end

  it "I can cancel an order" do
    visit "/profile/orders/#{@order_1.id}"
    click_button("Cancel Order")
    expect(current_path).to eq("/profile")
    expect(page).to have_content("Order #{@order_1.id} is now cancelled.")
  end
end
