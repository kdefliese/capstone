require 'rails_helper'

RSpec.describe MealsController, type: :controller do

  let(:good_params) do
    {meal: {
      name: "Pancakes",
      foods_list: ["foods"],
      ingredients_list: ["stuff"],
      category: "Breakfast",
      user_id: 1
      }
    }
  end

  let(:bad_params) do
    {meal: {
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
      expect(Meal.all.length).to eq 1
      expect(response.status).to eq 302
      expect(subject).to redirect_to meal_path(Meal.last)
    end
    it "unsuccessful create renders new page" do
      post :create, bad_params
      expect(Meal.all.length).to eq 0
      expect(response.status).to eq 200
      expect(subject).to render_template :new
    end
  end

  describe "GET 'show'" do
    it "is successful" do
      meal = Meal.create(good_params[:meal])
      get :show, id: meal.id
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
