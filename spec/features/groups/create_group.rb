require 'spec_helper'

describe "Creating groups" do
  it "redirects to the group list index page on success" do
    visit "/groups"
    click_link "New Group"
    expect(page).to have_content("New group")

    fill_in "Name", with: "Testgroup"

    select "2013", from: "group[creationDate(1i)]"
    select "February", from: "group[creationDate(2i)]"
    select "26", from: "group[creationDate(3i)]"

    click_button "Create Group"

    expect(page).to have_content("Testgroup")
  end

  it "displays an error when the group has no name" do
    expect(Group.count).to eq(0)

    visit "/groups"
    click_link "New Group"
    expect(page).to have_content("New group")

    fill_in "Name", with: ""

    select "2013", from: "group[creationDate(1i)]"
    select "February", from: "group[creationDate(2i)]"
    select "26", from: "group[creationDate(3i)]"

    click_button "Create Group"

    expect(page).to have_content("error")
    expect(Group.count).to eq(0)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end

  it "displays an error when the group has a name less then 3 characters" do
    expect(Group.count).to eq(0)

    visit "/groups"
    click_link "New Group"
    expect(page).to have_content("New group")

    fill_in "Name", with: "Hi"

    select "2013", from: "group[creationDate(1i)]"
    select "February", from: "group[creationDate(2i)]"
    select "26", from: "group[creationDate(3i)]"

    click_button "Create Group"

    expect(page).to have_content("error")
    expect(Group.count).to eq(0)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end
end
