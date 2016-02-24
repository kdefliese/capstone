require 'rails_helper'

RSpec.describe Food, type: :model do
  describe "model validations" do
    let(:good_food) do
      Food.create({
      product_name: "cheese",
      sensitivity_groups: ["dairy"]
      })
    end

    let(:bad_food) do
      Food.new
    end

    it "requires an food to have a name" do
      expect(bad_food).to be_invalid
      expect(bad_food.errors.keys).to include :product_name
    end
  end
end
