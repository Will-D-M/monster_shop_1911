require 'rails_helper'

describe "As a  merchant on the order show page" do
  before :each do
    @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zb0y@hotmail.com", password: "sfgdfg", role: 0)
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @user2 = @mike.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy1233@hotmail.com", password: "sfgdfg", role: 1)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
    @item_order_1 = @order_1.item_orders.create!(item: @pencil, price: @pencil.price, quantity: 2)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
    visit "/merchant/orders/#{@order_1.id}"
  end

  it "I can see order details" do
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

  it 'has button to delete' do
    expect(page).to have_button("Cancel Order")
  end

  it 'should only show items from the merchant' do
    bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    chain = @mike.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
    huffy = bike_shop.items.create(name: "Huffy Bike", description: "Great for tailwhips!", price: 250, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
    @order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2)
    @order_1.item_orders.create!(item: huffy, price: huffy.price, quantity: 2)
    visit "/merchant/orders/#{@order_1.id}"

    expect(page).to have_link(@pencil.name)
    expect(page).to have_link(chain.name)

    expect(page).to_not have_link(huffy.name)
  end
end
