require 'spec_helper'

describe "Adding group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creationDate: "2012-02-01") }

  def visit_group(group)
    visit "/groups"
    within "#group_#{group.id}" do
      click_link "List Dates"
    end
  end

  it "is successful with valid name" do
    visit_group(group)
    click_link "New Group Date"
    fill_in "Name", with: "Testdate"
    click_button "Save"

    expect(page).to have_content("Added group date.")

    within("ul.group_dates") do
      expect(page).to have_content("Testdate")
    end
  end

  it "displays an error with no name" do
    visit_group(group)
    click_link "New Group Date"
    fill_in "Name", with: ""
    click_button "Save"

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that group date.")
    end

    expect(page).to have_content("Name can't be blank")
  end

  it "displays an error with a name less then 2 characters long" do
    visit_group(group)
    click_link "New Group Date"
    fill_in "Name", with: "1"
    click_button "Save"

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that group date.")
    end

    expect(page).to have_content("Name is too short")
  end
end
