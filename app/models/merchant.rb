class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :items

  def self.search_name(name)
    where("name ILIKE ?", "%#{name}%").first
  end
end