require "rails_helper"

RSpec.describe 'As a visitor of my cart page' do
  before :each do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 2)
    @cart = Cart.new({@chain.id.to_s => 1})
    visit "/items/#{@chain.id}"
    click_on "Add To Cart"
    visit '/cart'

  end
  it 'should increment quantity' do
    within "#cart-quantity-#{@chain.id}" do
      expect(page).to have_content("1")
      find('#increment').click
      expect(page).to have_content("2")
    end
  end

  it 'should decrement quantity' do
    within "#cart-quantity-#{@chain.id}" do
      expect(page).to have_content("1")
      find('#increment').click
      expect(page).to have_content("2")
      find('#decrement').click
      expect(page).to have_content("1")
    end
  end

  it 'cant increment past inventory quantity' do
    within "#cart-quantity-#{@chain.id}" do
      expect(page).to have_content("1")
      find('#increment').click
      expect(page).to have_content("2")
      find('#increment').click
      expect(page).to have_content("2")
    end
  end

  it 'removes item at zero quantity' do
    within "#cart-quantity-#{@chain.id}" do
      expect(page).to have_content("1")
      find('#decrement').click
    end
    expect(page).to_not have_content(@chain.name)
  end
end
