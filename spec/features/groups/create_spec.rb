require 'spec_helper'

describe "Creating groups" do
  it "redirects to the group list index page on success" do
    create_group
    expect(page).to have_content("Testgroup")
  end

  it "displays an error when the group has no name" do
    expect(Group.count).to eq(0)

    create_group name: ""

    expect(page).to have_content("error")
    expect(Group.count).to eq(0)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end

  it "displays an error when the group has a name less then 3 characters" do
    expect(Group.count).to eq(0)

    create_group name: "Hi"

    expect(page).to have_content("error")
    expect(Group.count).to eq(0)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end
end
