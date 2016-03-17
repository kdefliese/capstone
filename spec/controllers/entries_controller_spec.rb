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
  
  before :each do
    user = User.create(user_params[:user])
    session[:user_id] = user.id
  end
end
