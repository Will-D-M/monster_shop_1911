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
      @discount_3 = @meg.discounts.create!(name: "10% Discount", percent_off: 10, min_quantity: 30)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit '/merchant/'
      click_link "Manage Bulk Discounts"
    end

    it "can edit a bulk discount" do

      within("#discount#{@discount_1.id}") do
        click_link "Edit Bulk Discount"
      end

      expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")

      fill_in "Name", with: ""
      fill_in "Percent off", with: 80
      click_on "Update Discount"
      expect(page).to have_content("Name can't be blank")

      fill_in "Name", with: "80% Discount"
      fill_in "Percent off", with: 80
      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_content("Bulk Discount has been updated.")
    end
  end
end
    # bike_shop.reload
