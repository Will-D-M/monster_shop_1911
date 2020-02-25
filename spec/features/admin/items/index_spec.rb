require 'rails_helper'

RSpec.describe 'As an admin user', type: :feature do
  before :each do
    @bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    @user_1 = @bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 2)
    @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @huffy = @meg.items.create(name: "Huffy", description: "Perfect for X-ups and Tail Whips!", price: 200, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 15)

  end
  it 'should show me an index page for only a specific merchants items' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit "/admin/merchants/#{@bike_shop.id}"
    click_on "View All Items"
    expect(current_path).to eq("/admin/merchant/#{@bike_shop.id}/items")

    expect(page).to have_content(@tire.name)
    expect(page).to have_content(@chain.name)

    expect(page).to_not have_content(@huffy.name)
  end
end
