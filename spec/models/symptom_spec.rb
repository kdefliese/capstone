require 'rails_helper'

RSpec.describe Symptom, type: :model do
  describe "model validations" do
    let(:good_symptom) do
      Symptom.create({
      name: "happiness",
      start_time: Time.now
      })
    end

    let(:bad_symptom) do
      Symptom.new
    end

    it "requires an symptom to have a name" do
      expect(bad_symptom).to be_invalid
      expect(bad_symptom.errors.keys).to include :name
    end

    it "requires an symptom to have a start time" do
      expect(bad_symptom).to be_invalid
      expect(bad_symptom.errors.keys).to include :start_time
    end
  end
end
