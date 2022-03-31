require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it 'searches by name' do
    merchant1 = Merchant.create(name: 'Murph')
    items = create_list(:item, 3, merchant_id: merchant1.id)

    expect(Merchant.search_name('Murph')).to be_a Merchant
  end
end