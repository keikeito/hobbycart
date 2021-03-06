# いいね！などのリアクションをつける
class Reaction < ApplicationRecord
  belongs_to :user

  # これ商品id、本当は柔軟にしたかったけど
  validates :target_id, presence: true
  validates :target_type, presence: true
  validates :stamp_code, presence: true

  def item
    Item.find_by(id: target_id)
  end

  class << self
    def already_good?(item, user)
      reaction = find_by(user: user, target_id: item.id, target_type: 'item', stamp_code: '1')
      reaction.present?
    end

    def good_to_item!(item, user)
      create!(user: user, target_id: item.id, target_type: 'item', stamp_code: '1')
    end

    def revoke_good_to_item!(item, user)
      reaction = find_by!(user: user, target_id: item.id, target_type: 'item', stamp_code: '1')
      reaction.destroy!
    end
  end
end
