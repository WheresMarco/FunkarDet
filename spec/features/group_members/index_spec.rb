require 'spec_helper'

describe "Visiting group members" do
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "displays the name of the group" do
    visit_group_members(group)
    within("h1") do
      expect(page).to have_content(group.name)
    end
  end

  it "displays no members when a group is empty" do
    visit_group_members(group)
    expect(page.all("ul.group_members li").size).to eq(0)
  end

  it "displays member content when a group has members" do
    group.group_members.create(name: "Kalle Kula", email: "kalle@kula.se")
    group.group_members.create(name: "Sture Stork", email: "sture@stork.se")

    visit_group_members(group)

    expect(page.all("ul.group_members li").size).to eq(2)

    within "ul.group_members" do
      expect(page).to have_content("Kalle Kula")
      expect(page).to have_content("Sture Stork")
    end
  end
end
