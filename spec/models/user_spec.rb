require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new(
    uid:      "123",
    provider: "github",
    name: "Cat",
    image: "https://i.ytimg.com/vi/tntOCGkgt98/maxresdefault.jpg")
  }

  let(:bad_user) { User.new(
    uid:      "123",
    provider: "github",
    name: "Cat",
    image: "https://i.ytimg.com/vi/tntOCGkgt98/maxresdefault.jpg")
  }

  let(:good_user) { User.new(
    uid:      "234",
    provider: "github",
    name: "Cat",
    image: "https://i.ytimg.com/vi/tntOCGkgt98/maxresdefault.jpg")
  }

  describe "validations" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "requires a uid" do
      user.uid = nil
      expect(user).to be_invalid
    end

    it "requires a unique uid" do
      user.save
      expect(bad_user.save).to be false
      expect(good_user.save).to be true
    end

    it "requires a provider" do
      user.provider = nil
      expect(user).to be_invalid
    end

    it "does not require an image" do
      user.image = nil
      expect(user).to be_valid
    end
  end

  describe ".initialize_from_omniauth" do
    let(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:prov]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when the user is invalid" do
      it "returns nil" do
        user = User.find_or_create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end

end
