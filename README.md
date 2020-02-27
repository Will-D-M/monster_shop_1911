# Monster Shop

BE Mod 2 Week 4/5 Group Project


## Application Description

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.

To see the website in action please click on the following link:


## Access Locally

* Fork and clone down the repo to your local machine.
* Install Ruby 2.6.3
* Install Rails 5.1.7
* Run bundle install
* Run bundle update
* Run rake db:create
* Run rake db:migrate

The Gemfile also uses several gems to help assist with testing:

* capybara
* pry
* rspec-rails
* simplecov
* shoulda-matchers

We also used the bcrypt gem to protect user passwords by hashing with a salt.


## User Roles

Our e-commerce site implements several user roles that allows for authentication
and authorization on specific parts of the website.

* Visitor - Unauthenticated, able to add items to their cart but unable to place
their order
* User - Authenticated with email, able to add items to their cart and place an
order and cancel their order
* Merchant Employee - Authenticated, able to add items along with price,
pictures, inventory. They are also able to approve their own items that are
pending that a user has placed.
* Admin - Authenticated, fills role of superadmin with access to all areas of
our application.


## Database Schema


<img width="1312" alt="Database_Schema" src="https://user-images.githubusercontent.com/12539215/75473424-0b1e0900-598d-11ea-8f13-e8852ff39c58.png">


## Code Snippets

Successfully used ActiveRecord queries with SQL injections to display the most and least ordered items.

```ruby
def self.most_ordered_items
    joins(:item_orders).select("items.*, sum(quantity)").where(active?: true).group(:id).order("sum DESC").limit(5)
 end

def self.least_ordered_items
    joins(:item_orders).select("items.*, sum(quantity)").where(active?: true).group(:id).order("sum").limit(5)
 end
```


## Project Collaborators

* De'Marcus Kirby - https://github.com/KirbyDD
* Matt Holmes - https://github.com/holmesm8
* Will Meighan - https://github.com/Will-Meighan
