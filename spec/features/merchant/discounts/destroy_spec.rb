require 'rails_helper'

RSpec.describe 'merchant dashboard', type: :feature do
  describe 'As a merchant user' do
    before :each do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy33@hotmail.com", password: "sfgdfg", role: 0)
      @user_2 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy123@hotmail.com", password: "test", role: 1)
      @discount_1 = @bike_shop.discounts.create!(name: "1% Discount", percent_off: 1, min_quantity: 10)
      @discount_2 = @bike_shop.discounts.create!(name: "5% Discount", percent_off: 5, min_quantity: 20)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit '/merchant/discounts'
    end

    it "can destroy a bulk discount" do

      expect(@bike_shop.discounts.count).to eq(2)

      within("#discount#{@discount_1.id}") do
        click_button("Delete Bulk Discount")
      end

      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_content("#{@discount_1.name} has been deleted.")
      expect(@bike_shop.discounts.count).to eq(1)
    end
  end
end
