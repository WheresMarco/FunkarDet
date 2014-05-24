require "spec_helper"

describe "Signing up" do
  it "allows a user to sign up for the site and creates the object in the database" do
    number_of_users = User.count

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "Username", with: "Marco"
    fill_in "Email", with: "marco@wheresmar.co"
    fill_in "Password", with: "treehouse1234"
    fill_in "Password confirmation", with: "treehouse1234"

    fill_in "Groupname", with: "Marco"
    #fill_in "Creation date", with: ""

    fill_in "Group username", with: "Lyran"
    fill_in "Group password", with: "treehouse1234"
    fill_in "Group password (again)", with: "treehouse1234"
    click_button "Sign Up"

    expect(User.count).to eq(number_of_users + 2)
  end
end
