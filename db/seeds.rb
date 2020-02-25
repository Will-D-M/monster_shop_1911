# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all
User.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
spoke = bike_shop.items.create(name: "Spoke", description: "You can ride it!", price: 300, image: "https://megaanswers.com/images_uploaded/How%20do%20the%20thin%20spokes%20and%20rims%20of%20bicycle%20wheels%20bear%20the%20weight.jpg", active?:true, inventory: 30)
bike = bike_shop.items.create(name: "Bike", description: "You can ride it!", price: 300, image: "https://surlybikes.com/uploads/bikes/_medium_image/Lowside_BK0887-2000x1333.jpg", active?:true, inventory: 30)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

user = User.create!(name: "default_user", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "default@hotmail.com", password: "sfgdfg", role: 0)
user_2 = User.create!(name: "merchant_employee", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "merchant@hotmail.com", password: "sfgdfg", role: 1, merchant_id: bike_shop.id)
user_3 = User.create!(name: "admin", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "admin@hotmail.com", password: "sfgdfg", role: 2)
user_4 = User.create!(name: "merchant_employee2", address: "123", city: "Bruh", state: "CO", zip: "99999", email: "merchant2@hotmail.com", password: "sfgdfg", role: 1, merchant_id: dog_shop.id)

order_1 = Order.create(name: 'Will', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: user.id, status: 0)
order_2 = Order.create(name: 'Bob', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: user_2.id, status: 1)
order_3 = Order.create(name: 'Bob', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: user_2.id, status: 2)
order_4 = Order.create(name: 'Will', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: user.id, status: 3)
order_5 = Order.create(name: 'Will', address: "123 main", city: "Denver", state: "CO", zip: 99999, user_id: user.id, status: 0)


order_1.item_orders.create(item: pull_toy, price: pull_toy.price, quantity: 9)
order_2.item_orders.create(item: dog_bone, price: pull_toy.price, quantity: 4)
order_2.item_orders.create(item: bike, price: bike.price, quantity: 2)
order_4.item_orders.create(item: pull_toy, price: pull_toy.price, quantity: 1)
order_5.item_orders.create(item: bike, price: bike.price, quantity: 1)
order_5.item_orders.create(item: dog_bone, price: dog_bone.price, quantity: 5)
