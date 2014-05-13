require "spec_helper"

describe "Logging in" do
  it "logs the user in as an organizer and goes to the group list" do
    User.create(username: "Jason", email: "jason@teamtreehouse.com", organizer: true, password: "treehouse1", password_confirmation: "treehouse1")

    visit new_user_session_path
    fill_in "Username", with: "Jason"
    fill_in "Password", with: "treehouse1"
    click_button "Log In"

    expect(page).to have_content("Listing groups")
    expect(page).to have_content("Thanks for logging in!")
  end

  it "displays the email adress in the event of a faild login" do
    visit new_user_session_path
    fill_in "Username", with: "Jason"
    fill_in "Password", with: "incorrect"
    click_button "Log In"

    expect(page).to have_content("Please check your username and password.")
    expect(page).to have_field("Username", with: "Jason")
  end
end
