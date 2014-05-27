require "spec_helper"

describe "Logging in" do
  let(:user) { group.user }
  let!(:group) { create(:group) }

  it "logs the user in as an organizer and goes to the group list" do
    visit new_user_session_path
    fill_in "Username", with: group.user.first.username
    fill_in "Password", with: "treehouse1"

    click_button "Log in"

    expect(page).to have_content("Thanks for logging in!")
  end

  it "displays the username in the event of a faild login" do
    visit new_user_session_path
    fill_in "Username", with: "Jason"
    fill_in "Password", with: "incorrect"
    click_button "Log in"

    expect(page).to have_content("Please check your username and password.")
    #expect(page).to have_field("Username", with: "Jason")
  end
end
