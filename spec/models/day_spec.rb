require 'rails_helper'

RSpec.describe Day, type: :model do
  describe "model validations" do
    let(:good_day) do
      Day.create({
      day: Time.new(2016, 01, 30),
      user_id: 1
      })
    end

    let(:bad_day) do
      Day.new
    end

    it "requires an day to have a date" do
      expect(bad_day).to be_invalid
      expect(bad_day.errors.keys).to include :date
    end
  end
end
