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

    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"
    visit "/cart"

    click_on "Checkout"

    name = "Bert"
    address = "123 Sesame St."
    city = "NYC"
    state = "New York"
    zip = 10001

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Create Order"
  end

  it "the show page contains the order details" do
    order = @pencil.orders.create(name: 'Will', address: '123', city: 'Denver', state: 'CO', zip: '80204')
    expect(current_path).to eq("/profile/orders")
    expect(page).to have_content("Order has been created.")
    expect(page).to have_content("Order ID: #{order.id}")
    expect(page).to have_content("Cart: 0")
  end

end
