require 'rails_helper'

describe "As a visitor on the order show page" do
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

  it "I can see order details" do
    visit "/profile/orders/#{@order_1.id}"

    expect(page).to have_content("Order ID: #{@order_1.id}")
    expect(page).to have_content("Order date: #{@order_1.created_at}")
    expect(page).to have_content("Last update: #{@order_1.updated_at}")
    expect(page).to have_content("Current status: #{@order_1.status}")
    expect(page).to have_content("Total items: #{@order_1.total_items}")
    expect(page).to have_content(@pencil.name)
    expect(page).to have_content(@pencil.description)
    expect(page).to have_css("img[src*='#{@pencil.image}']")
    expect(page).to have_content(@item_order_1.quantity)
    expect(page).to have_content(@pencil.price)
    expect(page).to have_content(@item_order_1.subtotal)
    expect(page).to have_content("Total price: $#{@order_1.grandtotal}")
  end
end
