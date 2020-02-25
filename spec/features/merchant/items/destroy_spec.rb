require 'rails_helper'

describe 'As a merchant employee', type: :feature do

  it 'I can delete an item that has never been ordered' do
    bike_shop = Merchant.create!(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
    user_1 = bike_shop.users.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "test", role: 1)
    tire = bike_shop.items.create(name: "Tire", description: "These tires suck ass!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 0)
    spoke = bike_shop.items.create(name: "Spoke", description: "I hate my life", price: 150, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 0)

    order_1 = Order.create(name: 'Will', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: user_1.id, status: 0)
    order_1.item_orders.create(item: spoke, price: spoke.price, quantity: 9)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

    visit '/merchant/items'
    click_button("Delete Item")
    expect(current_path).to eq("/merchant/items")
    expect(page).to have_content("#{tire.name} has been deleted.")
    bike_shop.reload
    visit current_path
    expect(page).to_not have_content("These tires suck ass!")
    expect(page).to_not have_content(tire.price)
  end

end
