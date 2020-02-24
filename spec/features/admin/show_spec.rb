require 'rails_helper'

describe 'As an admin on the show page' do
  before :each do
    @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "default@gmail.com", password: "sfgdfg", role: 0)
    @user_2 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "admin@admin.com", password: "sfgdfg", role: 2)

    visit '/'
    click_on "Log In"
    fill_in "Email", with: "admin@admin.com"
    fill_in "Password", with: "sfgdfg"
    click_on "Login"

    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @order_1 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    @item_order_1 = @order_1.item_orders.create(item: @pencil, price: @pencil.price, quantity: 2)

    visit "/admin/profile/#{@user.id}"
  end

  it 'can see the user info' do
    expect(page).to have_content("User Info")
    expect(page).to have_content("Name: #{@order_1.user.name}")
    expect(page).to have_content("Address: #{@order_1.user.address}")
    expect(page).to have_content("City: #{@order_1.user.city}")
    expect(page).to have_content("State: #{@order_1.user.state}")
    expect(page).to have_content("Zip: #{@order_1.user.zip}")
    expect(page).to have_content("Email: #{@order_1.user.email}")
  end

end
