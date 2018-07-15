# 商品購入明細
class ItemPurchaseLog < ApplicationRecord
  belongs_to :item
  belongs_to :user

  class << self
    def purchase!(user, item)
      create!(
        user: user,
        item: item,
        name: item.name,
        price: item.price
      )
    end
  end
end
