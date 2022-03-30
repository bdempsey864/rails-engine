class ItemSerializer
  include JSONAPI::Serializer
  attributes :merchant_id, :name, :description, :unit_price
end
