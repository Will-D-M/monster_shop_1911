require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'instance methods' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @cart = Cart.new({@chain.id.to_s => 1})
    end

    it '#add_quantity' do
      @cart.add_quantity(@chain.id.to_s)
      expect(@cart.contents[@chain.id.to_s]).to eq(2)
    end

    it 'subtract_quantity' do
      @cart.add_quantity(@chain.id.to_s)
      expect(@cart.contents[@chain.id.to_s]).to eq(2)
      @cart.subtract_quantity(@chain.id.to_s)
      expect(@cart.contents[@chain.id.to_s]).to eq(1)
    end

    it '#limit_reached?' do
      @cart = Cart.new({@chain.id.to_s => 5})
      expect(@cart.limit_reached?(@chain.id.to_s)).to eq(true)
      @cart.subtract_quantity(@chain.id.to_s)
      expect(@cart.limit_reached?(@chain.id.to_s)).to eq(false)
    end

    it '#quantity_zero?' do
      expect(@cart.quantity_zero?(@chain.id.to_s)).to eq(false)
      @cart.subtract_quantity(@chain.id.to_s)
      expect(@cart.quantity_zero?(@chain.id.to_s)).to eq(true)
    end

  end
end
