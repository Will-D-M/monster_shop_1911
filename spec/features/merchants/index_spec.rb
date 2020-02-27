require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
      @user_1 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    end

    it 'I can see a list of merchants in the system' do
      visit '/merchants'

      expect(page).to have_link("Brian's Bike Shop")
      expect(page).to have_link("Meg's Dog Shop")
    end

    it 'I can see a link to create a new merchant' do
      visit '/merchants'

      expect(page).to have_link("New Merchant")

      click_on "New Merchant"

      expect(current_path).to eq("/merchants/new")
    end
  end

  describe "as an admin" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "admin@admin.com", password: "sfgdfg", role: 2)
      @tire = @bike_shop.items.create(name: "Tire", description: "You rubber it.", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      @bone = @dog_shop.items.create(name: "Bone", description: "You bone it", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit '/'
      click_on "Log In"
      fill_in "Email", with: "admin@admin.com"
      fill_in "Password", with: "sfgdfg"
      click_on "Login"
    end
    it "can disable/enable a merchant account" do
      visit '/admin/merchants'
      within "#merchant-#{@bike_shop.id}" do
        click_on "Disable"
      end
      expect(current_path).to eq("/admin/merchants")
      expect(page).to have_content("#{@bike_shop.name} is now disabled.")
      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_content("Disabled")
        expect(page).to_not have_button("Disable")
      end
      within "#merchant-#{@bike_shop.id}" do
        click_button "Enable"
      end
      expect(page).to have_content("#{@bike_shop.name} is now enabled.")
      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_button("Disable")
      end
    end
  end
end
