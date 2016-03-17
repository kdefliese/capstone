require 'rails_helper'

RSpec.describe DaysController, type: :controller do
  let(:day) do
    Day.create(day: DateTime.new(2016,03,17), user_id: 1)
  end

  let(:other_day) do
    Day.create(day: DateTime.new(2016,03,17), user_id: 2)
  end

  let(:good_params) do
    { user: {
        name: "kdefliese",
        email: "kdefliese@gmail.com",
        uid: "11111111",
        provider: "test",
        notifications_preference: true}
    }
  end


  describe "GET 'show'" do
    it "renders the show day page if trying to view a day that belongs to you" do
      user = User.create(good_params[:user])
      session[:user_id] = user.id
      get :show, id: day.id
      expect(subject).to render_template :show
    end

    it "redirects to today if trying to view a day that doesn't belong to you" do
      user = User.create(good_params[:user])
      session[:user_id] = user.id
      get :show, id: other_day.id
      expect(subject).to redirect_to day_path(Day.last)
    end
  end

end
