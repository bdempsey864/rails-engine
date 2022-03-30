require 'rails_helper'

describe "Items API" do
  it "gets all items" do
    merchant1 = Merchant.create(name: 'Bosco')
    create_list(:item, 3, merchant_id: merchant1.id)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
  end

  it 'gets one item by id' do
    merchant1 = Merchant.create(name: 'Bosco')
    id = create(:item, merchant_id: merchant1.id).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(item).to have_key(:id)
    expect(item[:id]).to eq(id)

    expect(item).to have_key(:name)
    expect(item[:name]).to be_a(String)

    expect(item).to have_key(:description)
    expect(item[:description]).to be_a String

    expect(item).to have_key(:unit_price)
    expect(item[:unit_price]).to be_a Float
  end

  it "can create a new item" do
    merchant1 = Merchant.create(name: 'Bosco')
    item_params = ({
                    name: 'Chocolate Syrup',
                    description: 'Georges Password',
                    unit_price: 25.6,
                    merchant_id: merchant1.id
                  })
    headers = {"CONTENT_TYPE" => "application/json"}
  
    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(response_body[:id]).to be_an Integer
    expect(response_body[:name]).to eq(item_params[:name])
    expect(response_body[:description]).to eq(item_params[:description])
    expect(response_body[:unit_price]).to eq(item_params[:unit_price])
  end

  it "can update an existing item" do
    merchant1 = Merchant.create(name: 'Bosco')
    id = create(:item, merchant_id: merchant1.id).id
    previous_name = Item.last.name
    item_params = { name: "Summer of George" }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: id)
  
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Summer of George")
  end

  it "can destroy an item" do
    merchant1 = Merchant.create(name: 'Bosco')
    item = create(:item, merchant_id: merchant1.id)
  
    expect(Item.count).to eq(1)
  
    delete "/api/v1/items/#{item.id}"
  
    expect(response).to be_successful
    expect(Item.count).to eq(0)
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end