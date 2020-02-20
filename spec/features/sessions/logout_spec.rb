require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  it "should let me logout" do
    user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test")

    visit '/login'

    fill_in :email, with: user.email
    fill_in :password, with: 'test'
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    click_on "Login"

    click_on "Log Out"
    expect(current_path).to eq('/')
    expect(page).to have_content("You have logged out")
  end
end
