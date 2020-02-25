require 'rails_helper'

RSpec.describe 'merchant dashboard', type: :feature do
  describe 'As a Admin user' do
    before :each do
      @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    end

    it 'I can impersonate merchants' do
      user_1 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy123@hotmail.com", password: "test", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
      visit "/merchants"
      click_on @bike_shop.name
      expect(current_path).to eq("/admin/merchants/#{@bike_shop.id}")

      expect(page).to have_content("Brian's Bike Shop")
      expect(page).to have_content("123 Bike Rd.\nRichmond, VA 23137")
    end
  end
end
