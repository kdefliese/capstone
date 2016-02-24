require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "model validations" do
    let(:good_ingredient) do
      Ingredient.create({
      name: "cheese",
      sensitivity_groups: ["dairy"]
      })
    end

    let(:bad_ingredient) do
      Ingredient.new
    end

    it "requires an ingredient to have a name" do
      expect(bad_ingredient).to be_invalid
      expect(bad_ingredient.errors.keys).to include :name
    end
  end
end
