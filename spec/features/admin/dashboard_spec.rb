require 'rails_helper'

describe 'As an admin on the admin dashboard' do
  before :each do
    @user = User.create(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)
    @user_2 = User.create(name: "Gerry", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "boy@hotmail.com", password: "sfgdfg", role: 2)

    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @order_1 = Order.create(name: 'Will', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)

    @order_1.item_orders.create(item: @tire, price: @tire.price, quantity: 2, status: 0 )

    visit '/'
    click_on 'Log In'
    fill_in :email, with: "boy@hotmail.com"
    fill_in :password, with: "sfgdfg"
    click_on 'Login'
  end

  it "I see all orders in the system" do
    visit '/admin'
    expect(page).to have_content("All Orders")
    expect(page).to have_content("Order ID: #{@order_1.id}")
    expect(page).to have_link(@order_1.name)
    expect(page).to have_content("Date created: #{@order_1.created_at}")
    click_on(@order_1.name)
    expect(current_path).to eq("/admin/profile/#{@order_1.user_id}")
  end

end
