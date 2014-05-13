require 'spec_helper'

describe "Visiting group members" do
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "displays no members when a group is empty" do
    visit_group_members(group)
    expect(page.all("ul.group_members li").size).to eq(0)
  end
end
