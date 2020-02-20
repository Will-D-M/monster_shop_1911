require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  it 'should greet the visitor' do
    visit "/"
    expect(page).to have_content("Welcome to Monster Shop where you can buy knickknacks, paddywacks, and maybe a bone for Fido.")
  end

  it "can click links in nav bar" do
    visit "/"

    click_link "All Merchants"
    expect(current_path).to eq("/merchants")

    click_link "Welcome"
    expect(current_path).to eq("/")

    click_link "All Items"
    expect(current_path).to eq("/items")

    click_link "Cart: 0"
    expect(current_path).to eq("/cart")

    click_link "Register"
    expect(current_path).to eq("/register")

    click_link "All Items"
    expect(current_path).to eq("/items")

    click_link "Log In"
    expect(current_path).to eq("/login")
  end
end
