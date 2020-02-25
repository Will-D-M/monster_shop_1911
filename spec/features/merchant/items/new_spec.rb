require 'rails_helper'

RSpec.describe 'As a mechant user', type: :feature do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @user_1 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 1)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @huffy = @meg.items.create(name: "Huffy", description: "Perfect for X-ups and Tail Whips!", price: 200, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 15)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
  end

  it 'I can add new items' do
    visit '/merchant/items'
    click_link "Add New Item"
    expect(current_path).to eq('/merchant/items/new')

    fill_in :name, with: 'Gloves'
    fill_in :description, with: 'Ride like a champ'
    fill_in :price, with: 30
    fill_in :inventory, with: 100

    click_on "Create Item"

    created_item = Item.last
    image = "https://images.squarespace-cdn.com/content/5351bd94e4b0cd2bba3ad77e/1398023186482-83G5YZ5Y26VCPXH7EWQE/TheShop_Logo_web_FN_white.png?content-type=image%2Fpng"

    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("Gloves has saved.")

    within "#item-#{created_item.id}" do
      expect(page).to have_content(created_item.name)
      expect(page).to have_content(created_item.description)
      expect(page).to have_css("img[src*='image']")
      expect(page).to have_content(created_item.price)
      expect(page).to have_content(created_item.inventory)
    end
  end

end
