require 'rails_helper'

RSpec.describe DaysController, type: :controller do
  let(:day) do
    Day.create(day: DateTime.new(2016,03,03), user_id: 1)
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
    it "renders the show day page" do
      user = User.create(good_params[:user])
      session[:user_id] = user.id
      get :show, id: day.id
      expect(subject).to render_template :show
    end
  end

end
