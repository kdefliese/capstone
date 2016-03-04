require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  let(:good_params) do
    {food: {
      name: "Flour",
      brand: "",
      ingredients_list: [],
      manufacturer: "",
      category: "",
      ean13: "",
      upc: "",
      factual_id: "",
      image_urls: "",
      sensitivity_groups: ["gluten"]
      }
    }
  end

  let(:bad_params) do
    {food: {
      }
    }
  end

  describe "GET 'new'" do
    it "is successful" do
      get :new
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "POST 'create'" do
    it "successful create redirects to show page" do
      post :create, good_params
      expect(Food.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to food_path(Food.last)
    end
    it "unsuccessful create renders new page" do
      post :create, bad_params
      expect(Food.all.length).to eq 0
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do
    it "is successful" do
      food = Food.create(good_params[:food])
      get :show, id: food.id
      expect(response.status).to eq 200
      expect(subject).to render_template :show
    end
  end

  describe "GET 'all'" do
    it "is successful" do
      get :all
      expect(response.response_code).to eq 200
    end

    it "returns json" do
      get :all
      expect(response.header['Content-Type']).to include 'application/json'
    end
  end
end
