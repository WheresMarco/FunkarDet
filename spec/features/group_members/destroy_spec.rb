require 'spec_helper'

describe "Deleting members" do
  let!(:group_member) { group.group_members.create(name: "Sture Stork", email: "sture@stork.se") }
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "is successful" do
    visit_group_members(group)
    
    within "#group_member_#{group_member.id}" do
      click_link "Delete"
    end

    expect(page).to have_content("Member was deleted.")
    #expect(GroupDate.count).to eq(0)
  end
end
