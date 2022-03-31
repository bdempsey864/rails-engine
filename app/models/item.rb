class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price, :merchant_id
  belongs_to :merchant

  def self.search_name(name)
    where("name ILIKE ?", "%#{name}%")
  end
end