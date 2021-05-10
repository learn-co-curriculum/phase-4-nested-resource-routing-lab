require 'rails_helper'

RSpec.describe "Items", type: :request do
  before do
    u1 = User.create(username: "Dwayne", city: "Los Angeles")
    u2 = User.create(username: "Lana", city: "New York")
    u1.items.create(name: "Non-stick pan", description: "Sticks a bit", price: 10)
    u2.items.create(name: "Ceramic plant pots", description: "Plants not included", price: 31)
  end

  let!(:user) { User.first }
  let!(:item) { user.items.first }

  describe "GET /users/:user_id/items" do
    it 'returns an array of all items with user info' do
      get "/users/#{user.id}/items"

      expect(response.body).to include_json([
        {
          id: a_kind_of(Integer),
          name: "Non-stick pan",
          description: "Sticks a bit",
          price: 10,
          user_id: user.id
        }
      ])
    end

    it 'returns a 404 response if the user is not found' do
      get "/users/bad_id/items"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /users/:user_id/items/:id" do
    it 'returns the item with the matching id' do
      get "/users/#{user.id}/items/#{item.id}"

      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        name: "Non-stick pan",
        description: "Sticks a bit",
        price: 10,
        user_id: user.id
      })
    end

    it 'returns a 404 response if the item is not found' do
      get "/users/#{user.id}/items/bad_id"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /users/:user_id/items" do
    let!(:item_params) { { name: "Garden gnomes", description: "No refunds", price: 23 } }

    it 'creates a new item belonging to a user' do
      expect { post "/users/#{user.id}/items", params: item_params }.to change(user.items, :count).by(1)
    end

    it 'returns the newly created item' do
      post "/users/#{user.id}/items", params: item_params
      
      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        name: "Garden gnomes",
        description: "No refunds",
        price: 23,
        user_id: user.id
      })
    end

    it 'returns a 404 response if the item is not found' do
      get "/users/#{user.id}/items/bad_id"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /items" do
    it 'returns an array of all items with user info' do
      get '/items'

      expect(response.body).to include_json([
        { 
          id: a_kind_of(Integer), 
          name: "Non-stick pan", 
          description: "Sticks a bit", 
          price: 10,
          user: {
            id: a_kind_of(Integer),
            username: "Dwayne",
            city: "Los Angeles"
          }
        }
      ])
    end
  end
end
