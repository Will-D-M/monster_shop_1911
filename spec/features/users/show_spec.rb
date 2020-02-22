require 'rails_helper'

describe "As a registered user on the profile page" do
  before :each do
    @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 0)
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    visit '/login'

    fill_in :email, with: @user.email
    fill_in :password, with: 'test'
    click_on "Login"

    visit '/profile'
  end

  it 'I see all the data of my profile except my password' do
    expect(page).to have_content("Name: #{@user.name}")
    expect(page).to have_content("Address: #{@user.address}")
    expect(page).to have_content("City: #{@user.city}")
    expect(page).to have_content("State: #{@user.state}")
    expect(page).to have_content("Zip: #{@user.zip}")
    expect(page).to have_content("Email: #{@user.email}")
    expect(page).to have_link("Edit Info")
    expect(page).to_not have_link("My Orders")
  end

  it 'I can click link to edit profile' do
    click_link("Edit Info")
    expect(current_path).to eq("/profile/edit")
    expect(find_field('Address').value).to eq("#{@user.address}")
    expect(find_field('City').value).to eq("#{@user.city}")
    expect(find_field('State').value).to eq("#{@user.state}")
    expect(find_field('Zip').value).to eq("#{@user.zip}")
    expect(find_field('Email').value).to eq("#{@user.email}")

    fill_in 'Address', with: ""
    click_on "Update Info"

    expect(page).to have_content("Address can't be blank")

    fill_in 'Address', with: "420 High St"
    click_on "Update Info"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Address: 420 High St")
    expect(page).to_not have_content("Address: 123")
    expect(page).to have_content("Information has been updated")
  end

  it 'I can click a link to edit password' do
    click_link "Change Password"
    expect(current_path).to eq("/password")

    fill_in "Password", with: "new_password"
    fill_in "Password confirmation", with: ""
    click_on "Submit"

    expect(page).to have_content("Passwords do not match")
    expect(current_path).to eq("/password")

    fill_in "Password", with: "new_password"
    fill_in "Password confirmation", with: "new_password"
    click_on "Submit"

    expect(current_path).to eq("/profile")
    expect(page).to have_content("Your password has been updated")
  end

  it 'I see a link to my orders if I have made any' do
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"
    visit "/cart"

    click_on "Checkout"

    name = "Bert"
    address = "123 Sesame St."
    city = "NYC"
    state = "New York"
    zip = 10001

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Create Order"

    visit '/profile'

    click_link("My Orders")
    expect(current_path).to eq("/profile/orders")
  end

end
