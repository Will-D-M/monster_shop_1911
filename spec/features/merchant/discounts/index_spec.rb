require 'rails_helper'

RSpec.describe 'merchant dashboard', type: :feature do
  describe 'As a merchant user' do
    before :each do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy33@hotmail.com", password: "sfgdfg", role: 0)
      @user_2 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy123@hotmail.com", password: "test", role: 1)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 100)
      @order_1 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_2 = Order.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17033, user_id: @user.id)
      @order_3 = Order.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17033, user_id: @user.id)
      @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 10)
      @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 10)
      @order_2.item_orders.create!(item: @chain, price: @chain.price, quantity: 10)
      @discount_1 = @bike_shop.discounts.create!(name: "1% Discount", percent_off: 1, min_quantity: 10)
      @discount_2 = @bike_shop.discounts.create!(name: "5% Discount", percent_off: 5, min_quantity: 20)
      @discount_3 = @meg.discounts.create!(name: "10% Discount", percent_off: 10, min_quantity: 30)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit '/merchant'
      click_link "Manage Bulk Discounts"
    end

    it "only displays your merchant discounts" do
      visit '/merchant'
      click_link "Manage Bulk Discount"

      within "#discount-#{@discount_1.id}" do
        expect(page).to have_content("Name: #{@discount_1.name}")
        expect(page).to have_content("Percent off: 1%")
        expect(page).to have_content("Minimum Quantity: #{@discount_1.quantity}")
        has_link "Edit Discount"
      end

      expect(page).to_not have_content(@discount_3.name)
    end
  end
end
