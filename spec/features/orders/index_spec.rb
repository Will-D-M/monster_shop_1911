require 'rails_helper'

RSpec.describe "As a user on the order index page" do
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
    @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
  end

  it "the page contains the order details" do

    visit("/profile/orders")

    expect(page).to have_content("Order ID: #{@order_1.id}")
    expect(page).to have_content("Order date: #{@order_1.created_at}")
    expect(page).to have_content("Last update: #{@order_1.updated_at}")
    expect(page).to have_content("Current status: #{@order_1.status}")
    expect(page).to have_content("Total items: #{@order_1.total_items}")
    expect(page).to have_link(@order_1.id)

    expect(page).to have_content("Cart: 0")
  end

  it 'id link takes you to order show page' do
    visit("/profile/orders")
    click_on(@order_1.id)
    expect(current_path).to eq("/profile/orders/#{@order_1.id}")
  end

  it 'displays a message when an order is created' do
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"

    visit "cart"
    click_on "Checkout"

    fill_in :name, with: "Will"
    fill_in :address, with: "Will"
    fill_in :city, with: "Will"
    fill_in :state, with: "Will"
    fill_in :zip, with: "Will"

    click_on "Create Order"

    expect(page).to have_content("Order has been created.")
  end

end
