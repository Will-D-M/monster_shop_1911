require 'rails_helper'

describe 'As a user on the edit profile page' do
  before :each do
    @user_1 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 0)
    @user_2 = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "xboy@hotmail.com", password: "test", role: 0)

    visit '/login'

    fill_in :email, with: @user_1.email
    fill_in :password, with: 'test'
    click_on "Login"

    visit '/profile'
    click_on "Edit Info"
  end

  it 'I see a flash message if an email is already in use' do
    fill_in 'Email', with: "xboy@hotmail.com"
    click_on "Update Info"
    expect(page).to have_content("Email has already been taken")
    expect(current_path).to eq("/profile/edit")
  end
end
