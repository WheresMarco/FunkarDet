require 'spec_helper'

describe "Deleting groups" do
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "is successful when clicking the destroy link" do
    number_of_groups = Group.count

    visit "/groups"

    within "#group_#{group.id}" do
      click_link "Destroy"
    end

    expect(page).to_not have_content(group.name)
    expect(Group.count).to eq(number_of_groups - 1)
  end
end
