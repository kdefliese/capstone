require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe "model validations" do
    let(:good_meal) do
      Meal.create({
      name: "cheese",
      sensitivity_groups: ["dairy"]
      })
    end

    let(:bad_meal) do
      Meal.new
    end

    it "requires an meal to have a name" do
      expect(bad_meal).to be_invalid
      expect(bad_meal.errors.keys).to include :name
    end
  end
end
