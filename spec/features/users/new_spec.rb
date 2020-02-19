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

      user1 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg")

      fill_in :name, with: "Will"
      fill_in :address, with: "Back Alley"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80205"
      fill_in :email, with: "zboy@hotmail.com"
      fill_in :password, with: "password1"
      fill_in :password_confirmation, with: "password1"

      click_on "Create User"

      expect(current_path).to eq("/register")
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
  end
end
