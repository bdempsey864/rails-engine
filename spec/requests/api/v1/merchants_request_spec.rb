require 'rails_helper'

describe "Merchants API" do
  it "gets all merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
  end

  it 'gets one merchant by id' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id].to_i).to eq(merchant.id)

    expect(json[:data][:attributes]).to have_key(:name)
    expect(json[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'gets all items based on merchant id' do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items"

    json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    item_ids = items.map do |item|
      item.id
    end
    # item_ids = items.map(&:id)

    json[:data].each do |item|
      expect(item[:attributes].keys.length).to eq(4)
      expect(item_ids.include?(item[:attributes][:merchant_id])).to eq(true)
    end
  end
end