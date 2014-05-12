require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    context "with correct credentials" do
      let!(:user) { User.create(username: "Jason", email: "jason@teamtreehouse.com", password: "treehouse1", password_confirmation: "treehouse1") }

      it "redirects to the group list path" do
        post :create, username: "Jason", password: "treehouse1"
        expect(response).to be_redirect
        expect(response).to redirect_to(groups_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by_username).with("jason").and_return(user)
        post :create, username: "Jason", password: "treehouse1"
      end

      it "authenticates the user" do
        User.stub(:find_by_username).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, username: "Jason", password: "treehouse1"
      end

      it "sets the user_id in the session" do
        post :create, username: "Jason", password: "treehouse1"
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets the flash success message" do
        post :create, username: "Jason", password: "treehouse1"
        expect(flash[:success]).to eq("Thanks for logging in!")
      end
    end

    shared_examples_for "denied login" do
      it "renders the new template" do
        post :create, username: username, password: password
        expect(response).to render_template('new')
      end

      it "sets the flash error message" do
        post :create, username: username, password: password
        expect(flash[:error]).to eq("There was a problem logging in. Please check your username and password.")
      end
    end

    context "with blank credentials" do
      let(:username) { "" }
      let(:password) { "" }
      it_behaves_like "denied login"
    end

    context "with an incorrect password" do
      let!(:user) { User.create(username: "Jason", email: "jason@teamtreehouse.com", password: "treehouse1", password_confirmation: "treehouse1") }
      let(:username) { user.username }
      let(:password) { "incorrect" }
      it_behaves_like "denied login"
    end

    context "with no email in existence" do
      let(:username) { "none@found.com" }
      let(:password) { "incorrect" }
      it_behaves_like "denied login"
    end
  end

end
