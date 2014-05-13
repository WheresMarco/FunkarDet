require 'spec_helper'

describe "Editing members" do
  let!(:group_member) { group.group_members.create(name: "Kalle", email: "kalle@kula.se") }
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "is successful with valid name" do
    visit_group_members(group)

    within "#group_member_#{group_member.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: "Sture"
    click_button "Save"

    expect(page).to have_content("Saved member.")
    group_member.reload

    expect(group_member.name).to eq("Sture")
  end

  it "is unsuccessful with no name" do
    visit_group_members(group)

    within "#group_member_#{group_member.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: ""
    click_button "Save"

    expect(page).to_not have_content("Saved group date.")
    expect(page).to have_content("Name can't be blank")
    group_member.reload

    expect(group_member.name).to eq("Kalle")
  end

  it "is unsuccessful with not enough name" do
    visit_group_members(group)

    within "#group_member_#{group_member.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: "1"
    click_button "Save"

    expect(page).to_not have_content("Saved group date.")
    expect(page).to have_content("Name is too short")
    group_member.reload

    expect(group_member.name).to eq("Kalle")
  end
end
