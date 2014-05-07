require 'spec_helper'

describe "Editing groups" do
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }

  it "updates a group successfully with correct information" do
    update_group group: group,
                 name: "New title"

    group.reload

    expect(page).to have_content("Group was successfully updated.")
    expect(group.name).to eq("New title")
  end

  it "displays an error with no name" do
      update_group group: group,
                   name: ""
      expect(page).to have_content("error")
  end

  it "displays an error with too short a name" do
      update_group group: group,
                   name: "Hi"
      expect(page).to have_content("error")
  end
end
