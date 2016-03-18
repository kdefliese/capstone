require 'rails_helper'

RSpec.describe EntriesController, type: :controller do
  let(:day) do
    Day.create(day: DateTime.new(2016,03,17), user_id: 1)
  end

  let(:user_params) do
    { user: {
        name: "kdefliese",
        email: "kdefliese@gmail.com",
        uid: "11111111",
        provider: "test",
        notifications_preference: true}
    }
  end

  let(:good_params) do
    {entry: {
      time: "10:00",
      user_id: 1,
      day_id: 1,
      category: "Breakfast",
      notes: "Notes"
      }
    }
  end

  let(:entry) do
    Entry.create(time: "10:00", user_id: 1, day_id: 1, category: "Breakfast", notes: "Notes")
  end

  let(:update_params) do {
      id: 1,
      time: "10:00",
      user_id: 1,
      day_id: 1,
      category: "Updated Breakfast",
      notes: "Notes"
    }
  end

  before :each do
    user = User.create(user_params[:user])
    session[:user_id] = user.id
  end

  describe "POST 'create'" do
    it "does not redirect" do
      post :create, good_params[:entry]
      expect(Entry.all.length).to eq 1
      expect(response.status).to eq 200
      expect(response.body).to be_blank
    end
  end

  describe "GET 'edit'" do
    it "is successful" do
      get :edit, id: entry.id
      expect(response.status).to eq 200
      expect(subject).to render_template :edit
    end
  end

  describe "PATCH 'update'" do
    it "does not redirect" do
      patch :update, update_params
      expect(Entry.all.length).to eq 1
      expect(response.status).to eq 200
      expect(response.body).to be_blank
    end
  end


end
