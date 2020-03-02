class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0

  before_save :default_values

  def default_values
    self.image = "https://images.squarespace-cdn.com/content/5351bd94e4b0cd2bba3ad77e/1398023186482-83G5YZ5Y26VCPXH7EWQE/TheShop_Logo_web_FN_white.png?content-type=image%2Fpng" if self.image.nil? || self.image == ""
  end

  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.most_ordered_items
    joins(:item_orders).select("items.*, sum(quantity)").where(active?: true).group(:id).order("sum DESC").limit(5)
  end

  def self.least_ordered_items
    joins(:item_orders).select("items.*, sum(quantity)").where(active?: true).group(:id).order("sum").limit(5)
  end

  def decrease_inventory(quantity)
    self.update(inventory: inventory - quantity)
  end

  def increase_inventory(quantity)
    self.update(inventory: inventory + quantity)
  end

  def active_false
    self.update(active?: false)
  end

  def active_true
    self.update(active?: true)
  end

  def no_order?
    ItemOrder.where(item_id: id).empty?
  end

end
