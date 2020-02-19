require 'rails_helper'

RSpec.describe "create user page", type: :feature do
  context "as a visitor" do
    before :each do

      visit "/items"
      within "nav" do
        click_link "Register"
      end

    end
    it "can register a new user" do

      expect(current_path).to eq("/register")

      fill_in :name, with: "Will"
      fill_in :address, with: "Back Alley"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80205"
      fill_in :email, with: "zboy@hotmail.com"
      fill_in :password, with: "password1"
      fill_in :password_confirmation, with: "password1"

      click_on "Create User"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are registered and now logged in.")
    end

    it "will not register an email already registered within the database" do

      user1 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)

      fill_in :name, with: "Will"
      fill_in :address, with: "Back Alley"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80205"
      fill_in :email, with: "zboy@hotmail.com"
      fill_in :password, with: "password1"
      fill_in :password_confirmation, with: "password1"

      click_on "Create User"

      expect(page).to have_content("Email is already in use, please try another.")
    end

    it "will not register a user if a field is left blank" do
      fill_in :name, with: "Will"
      fill_in :address, with: "Back Alley"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80205"
      fill_in :email, with: "zghjfhjgfy@hotmail.com"

      click_on "Create User"

      expect(page).to have_content("Please fill out all required fields.")
    end

    it "can pre-populate form with previous info" do
      fill_in :name, with: "Will"
      fill_in :address, with: "Back Alley"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80205"
      fill_in :email, with: "zghjfhjgfy@hotmail.com"

      click_on "Create User"

      fill_in :email, with: "zghjfhjgfy@hotmail.com"
      fill_in :password, with: "hunter2"
      fill_in :password_confirmation, with: "hunter2"

      click_on "Create User"

      expect(current_path).to eq("/profile")
    end

    it "can login as default user" do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)

      visit '/'

      click_link 'Log In'

      expect(current_path).to eq('/login')

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on 'Login'

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome, #{user.name}")
      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Register')
      expect(page).to_not have_link('Log In')

    end

    it 'can login as a merchant employee' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 1)

      visit '/'

      click_link 'Log In'

      expect(current_path).to eq('/login')

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on 'Login'

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome, #{user.name}")
      expect(page).to have_link('Merchant Dashboard')
    end

    it 'can login as an admin' do
      user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 2)

      visit '/'

      click_link 'Log In'

      expect(current_path).to eq('/login')

      fill_in :email, with: user.email
      fill_in :password, with: user.password

      click_on 'Login'

      expect(current_path).to eq('/')
      expect(page).to have_content("Welcome, #{user.name}")
      expect(page).to have_link('Admin Dashboard')
      expect(page).to have_link('See All Users')
      expect(page).to_not have_link("Cart: 0")
    end

    it 'cannot visit admin or merchant page' do
      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist")

      visit '/admin'
      expect(page).to have_content("The page you were looking for doesn't exist")

      visit '/profile'
      expect(page).to have_content("The page you were looking for doesn't exist")
    end

  end
end
