require 'rails_helper'

RSpec.describe 'As a mechant user', type: :feature do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @user_1 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 1)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
  end

  it 'I can edit an item' do
    visit '/merchant/items'
    click_on "Edit Item"
    expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")

    expect(find_field(:name).value).to eq(@tire.name)
    expect(find_field(:description).value).to eq(@tire.description)
    expect(find_field(:price).value).to eq(@tire.price.to_s)
    expect(find_field(:inventory).value).to eq(@tire.inventory.to_s)

    fill_in :name, with: ""
    click_on "Edit Item"

    expect(page).to have_content("Name can't be blank")

    fill_in :name, with: "Bo"
    click_on "Edit Item"
    expect(page).to have_content("Item has been updated")
  end
end
