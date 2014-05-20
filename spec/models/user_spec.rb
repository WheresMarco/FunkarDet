require 'spec_helper'

describe User do
  let(:valid_attributes) {
    {
      username: "Marco",
      email: "marco@wheresmar.co",
      password: "treehouse1234",
      password_confirmation: "treehouse1234"
    }
  }

  context "reletionships" do
    it { should have_and_belong_to_many(:groups) }
  end

  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires a username" do
      expect(user).to validate_presence_of(:username)
    end

    it "requires a unique username" do
      expect(user).to validate_uniqueness_of(:username)
    end

    it "requires an email" do
      expect(user).to validate_presence_of(:email)
    end

    it "requires the email adress to look like an email" do
      user.email = "marco"
      expect(user).to_not be_valid
    end
  end

  context "#downcase_username" do
    it "makes the username attribute lower case" do
      user = User.new(valid_attributes.merge(username: "MARCO"))
      expect{ user.downcase_username }.to change{ user.username }.
        from("MARCO").
        to("marco")
    end

    it "downcases an username before saving" do
      user = User.new(valid_attributes)
      user.username = "MARCO"
      expect(user.save).to be_true
      expect(user.username).to eq("marco")
    end
  end

  context "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "MARCO@WHERESMAR.CO"))
      expect{ user.downcase_email }.to change{ user.email }.
        from("MARCO@WHERESMAR.CO").
        to("marco@wheresmar.co")
    end

    it "downcases an email before saving" do
      user = User.new(valid_attributes)
      user.email = "MARCO@WHERESMAR.CO"
      expect(user.save).to be_true
      expect(user.email).to eq("marco@wheresmar.co")
    end
  end
end
