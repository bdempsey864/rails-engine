require 'rails_helper'

describe 'Merchants Search API' do
  it 'searches for a merchant' do
    create_list(:merchant, 3)
    
    get "/api/v1/merchants/find?name=#{Merchant.first.name}"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data][:attributes][:name]).to eq(Merchant.first.name)
    expect(merchants[:data][:attributes][:name]).to_not eq(Merchant.last.name)
  end
end