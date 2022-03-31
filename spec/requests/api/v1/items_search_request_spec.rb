require 'rails_helper'

describe 'Items Search API' do
  it 'searches for items based on search criteria' do
    create_list(:merchant, 3)
    create_list(:item, 3)
    
    get "/api/v1/items/find_all?name=#{Item.first.name}"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data][:attributes][:name]).to eq(Merchant.first.name)
    expect(merchants[:data][:attributes][:name]).to_not eq(Merchant.last.name)
  end
end