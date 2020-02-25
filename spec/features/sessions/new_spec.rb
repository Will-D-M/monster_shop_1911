require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  describe "when not logged in" do
    it 'should let me log in with valid credentials' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy10@hotmail.com", password: "test")

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: 'test'
      click_on "Login"

      expect(current_path).to eq('/profile')
      expect(page).to have_content("Login Successful")
    end

    it 'should let me log in with valid credentials as merchant' do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy11@hotmail.com", password: "test", role: 1)

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: 'test'
      click_on "Login"

      expect(current_path).to eq('/merchant')
      expect(page).to have_content("Login Successful")
    end

    it 'should let me log in with valid credentials as admin' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy12@hotmail.com", password: "test", role: 2)

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: 'test'
      click_on "Login"

      expect(current_path).to eq('/admin')
      expect(page).to have_content("Login Successful")
    end

    it 'should not let me log in with bad credentials' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy13@hotmail.com", password: "test")

      visit '/login'

      fill_in :email, with: user.email
      fill_in :password, with: 'test1'
      click_on "Login"

      expect(current_path).to eq('/login')
      expect(page).to have_content("Invalid Email and/or Password")
    end
  end

  describe "when already logged in" do
    it 'should route me to /profile' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy14@hotmail.com", password: "test")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'

      expect(current_path).to eq('/profile')
      expect(page).to have_content("You are already logged in!")
    end

    it 'should route me to /merchant' do
      bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      user = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy11@hotmail.com", password: "test", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'

      expect(current_path).to eq('/merchant')
      expect(page).to have_content("You are already logged in!")
    end

    it 'should route me to /admin' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/login'

      expect(current_path).to eq('/admin')
      expect(page).to have_content("You are already logged in!")
    end
  end
end
