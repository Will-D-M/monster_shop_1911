require 'rails_helper'

RSpec.describe 'As a merchant user', type: :feature do
  it 'should deactivate items' do
    bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    user_1 = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    tire = bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    visit '/merchant/items'
    within "#item-#{tire.id}" do
      expect(page).to have_link('Deactivate')
      click_on "Deactivate"
    end
    tire.reload
    expect(page).to have_content("#{tire.name} is no longer for sale.")
    within "#item-#{tire.id}" do
      visit current_path
      expect(page).to have_link('Activate')
    end
    expect(tire.active?).to eq(false)
  end

  it 'should activate items' do
    bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    user_1 = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy224@hotmail.com", password: "test", role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)
    tire = bike_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12, active?: false)

    visit '/merchant/items'
    within "#item-#{tire.id}" do
      expect(page).to have_link('Activate')
      click_on "Activate"
    end
    tire.reload
    expect(page).to have_content("#{tire.name} is now available for sale.")
    within "#item-#{tire.id}" do
      visit current_path
      expect(page).to have_link('Deactivate')
    end
    expect(tire.active?).to eq(true)
  end

end
