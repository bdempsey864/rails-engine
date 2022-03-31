require 'rails_helper'

RSpec.describe Item, type: :model do
  it 'Item search by name' do
    merchant1 = Merchant.create(name: 'Murph')
    items = create_list(:item, 3, merchant_id: merchant1.id)

    expect(Item.search_name(items.first.name).count).to eq(1)
  end
end