require 'rails_helper'

describe 'As an admin on the admin dashboard' do
  before :each do
    @user = User.create(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)
    @user_2 = User.create(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "boy@hotmail.com", password: "sfgdfg", role: 2)

    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

    @order_1 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    @order_2 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)

    @order_1.item_orders.create(item: @tire, price: @tire.price, quantity: 2, status: 'fulfilled' )
    @order_2.item_orders.create(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: 'fulfilled')

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
    expect(page).to have_link(@user.name)
    expect(page).to have_content("Date created: #{@order_1.created_at}")
  end

end
