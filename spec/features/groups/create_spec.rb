require 'spec_helper'

describe "Creating groups" do
  let(:user) { create(:user) }

  before do
    sign_in user, password: "treehouse1"
  end

  it "redirects to the group list index page on success" do
    create_group
    expect(page).to have_content("Testgroup")
  end

  it "displays an error when the group has no name" do
    number_of_groups = Group.count

    create_group name: ""

    expect(page).to have_content("error")
    expect(Group.count).to eq(number_of_groups)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end

  it "displays an error when the group has a name less then 3 characters" do
    number_of_groups = Group.count

    create_group name: "Hi"

    expect(page).to have_content("error")
    expect(Group.count).to eq(number_of_groups)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end
end
