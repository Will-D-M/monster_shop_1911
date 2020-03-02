class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip

  belongs_to :user
  has_many :item_orders, dependent: :destroy
  has_many :items, through: :item_orders

  enum status: %w(pending cancelled packaged shipped)

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

  def ship
    self.update(status: "shipped")
  end

  def items_count merchant_id
    Order.joins(:items)
      .where('item_orders.order_id = ?', self.id)
      .where('items.merchant_id = ?', merchant_id)
      .sum('item_orders.quantity')
  end

  def items_value merchant_id
    Order.joins(:items)
      .where('item_orders.order_id = ?', self.id)
      .where('items.merchant_id = ?', merchant_id)
      .sum('item_orders.price * item_orders.quantity')
  end

  def merchant_order_items merchant_id
    item_orders.joins(:item).where('items.merchant_id = ?', merchant_id)
  end
end
