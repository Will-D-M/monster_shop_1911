require 'rails_helper'

RSpec.describe 'merchant dashboard', type: :feature do
  describe 'As a merchant user' do
    before :each do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy33@hotmail.com", password: "sfgdfg", role: 0)
      @user_2 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy123@hotmail.com", password: "test", role: 1)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_2 = Order.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17033, user_id: @user.id)
      @order_3 = Order.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17033, user_id: @user.id)
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 3)
      @order_2.item_orders.create!(item: @chain, price: @chain.price, quantity: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
    end

    it 'I can see a merchants name, address, city, state, zip' do
      visit "/merchant"

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end

    it 'should show pending orders' do

      visit "/merchant"
      within "#orders-#{@order_1.id}" do
        expect(page).to have_link(@order_1.id)
        expect(page).to have_content("Date Ordered: #{@order_1.created_at}")
        expect(page).to have_content("Number of Items: #{@order_1.items_count(@bike_shop.id)}")
        expect(page).to have_content("Total Value of Items: $#{@order_1.items_value(@bike_shop.id)}")
      end

      within "#orders-#{@order_2.id}" do
        expect(page).to have_link(@order_2.id)
        expect(page).to have_content("Date Ordered: #{@order_2.created_at}")
        expect(page).to have_content("Number of Items: #{@order_2.items_count(@bike_shop.id)}")
        expect(page).to have_content("Total Value of Items: $#{@order_2.items_value(@bike_shop.id)}")
      end

      expect(page).to_not have_link(@order_3.id)
    end

    it "can click on a link to a new page to manage discounts" do
      visit '/merchant'
      click_link "Manage Bulk Discounts"
      expect(current_path).to eq("/merchant/discounts")
    end
  end
end
