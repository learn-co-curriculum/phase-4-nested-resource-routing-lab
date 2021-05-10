require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) do
    user = User.create(username: "Dwayne", city: "Los Angeles")
    user.items.create(name: "Non-stick pan", description: "Sticks a bit", price: 10)
    user.items.create(name: "Ceramic plant pots", description: "Plants not included", price: 31)
    user
  end

  describe "GET /users/:id" do
    it 'returns a user with an array of all items associated with that user' do
      get "/users/#{user.id}"

      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        username: "Dwayne",
        city: "Los Angeles",
        items: [
          { 
            id: a_kind_of(Integer), 
            name: "Non-stick pan", 
            description: "Sticks a bit", 
            price: 10
          }
        ]
      })
    end
  end
end
