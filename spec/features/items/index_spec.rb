require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @user = User.create!(name: "Tommy", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "zboy@hotmail.com", password: "sfgdfg", role: 0)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @chain = @brian.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @handle = @brian.items.create(name: "Handle", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @wheel = @brian.items.create(name: "Wheel", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @seat = @brian.items.create(name: "Seat", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @frame = @brian.items.create(name: "Frame", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @x = @brian.items.create(name: "x", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @y = @brian.items.create(name: "y", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @z = @brian.items.create(name: "z", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @a = @brian.items.create(name: "a", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)
      @b = @brian.items.create(name: "b", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 10)

      @order_1 = Order.create(name: 'Will', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: @user.id)
      @order_1.item_orders.create(item: @chain, price: @chain.price, quantity: 5)

      @order_2 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_2.item_orders.create(item: @frame, price: @frame.price, quantity: 4)

      @order_3 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_3.item_orders.create(item: @wheel, price: @wheel.price, quantity: 3)

      @order_4 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_4.item_orders.create(item: @seat, price: @seat.price, quantity: 2)

      @order_5 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_5.item_orders.create(item: @handle, price: @handle.price, quantity: 1)

      @order_10 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_10.item_orders.create(item: @x, price: @x.price, quantity: 10)

      @order_9 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_9.item_orders.create(item: @y, price: @y.price, quantity: 9)

      @order_8 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_8.item_orders.create(item: @z, price: @z.price, quantity: 8)

      @order_7 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_7.item_orders.create(item: @a, price: @a.price, quantity: 7)

      @order_6 = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, user_id: @user.id)
      @order_6.item_orders.create(item: @b, price: @b.price, quantity: 6)

      ItemOrder.new(item_id: @pull_toy.id, order_id: @order_1.id)
    end

    it "all items or merchant names or pictures are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to_not have_link(@dog_bone.name)

      expect(page).to have_css("img[src*='#{@tire.image}']")
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end
    end

    it "can display top 5 most popular and bottom 5 least popular items and quantity bought" do
      visit '/items'

      within '#most_popular' do
        expect(page).to have_content("Most popular items:")
        expect(page).to have_content("Name: #{@x.name}")
        expect(page).to have_content("Name: #{@y.name}")
        expect(page).to have_content("Name: #{@z.name}")
        expect(page).to have_content("Name: #{@a.name}")
        expect(page).to have_content("Name: #{@b.name}")
        expect(page).to have_content("Quantity sold: 6")
        expect(page).to have_content("Quantity sold: 7")
        expect(page).to have_content("Quantity sold: 8")
        expect(page).to have_content("Quantity sold: 9")
        expect(page).to have_content("Quantity sold: 10")
      end

      within '#least_popular' do
        expect(page).to have_content("Least popular items:")
        expect(page).to have_content("Name: #{@frame.name}")
        expect(page).to have_content("Name: #{@wheel.name}")
        expect(page).to have_content("Name: #{@handle.name}")
        expect(page).to have_content("Name: #{@seat.name}")
        expect(page).to have_content("Name: #{@chain.name}")
        expect(page).to have_content("Quantity sold: 1")
        expect(page).to have_content("Quantity sold: 2")
        expect(page).to have_content("Quantity sold: 3")
        expect(page).to have_content("Quantity sold: 4")
        expect(page).to have_content("Quantity sold: 5")
      end
    end
  end
end
