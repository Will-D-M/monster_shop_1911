class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: %w(pending cancelled packaged)

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    item_orders.sum(:quantity)
  end

  def fulfilled?
    self.item_orders.all? do |item_order|
      item_order.status == 'fulfilled'
    end
  end

  def packaged
    if fulfilled?
      self.status = "packaged"
    end
  end

end
