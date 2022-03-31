require 'rails_helper'

describe 'Items Search API' do
  it 'searches for items based on search criteria' do
    merchant1 = Merchant.create(name: 'CCM')
    create_list(:item, 3, merchant_id: merchant1.id)

    get "/api/v1/items/find_all?name=#{Item.first.name}"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to_not eq(3)
    expect(items[:data].first[:attributes][:name]).to eq(Item.first.name)
    expect(items[:data].first[:attributes]).to have_key(:name)
    expect(items[:data].first[:attributes]).to have_key(:description)
  end
end