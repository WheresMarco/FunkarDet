require 'spec_helper'

describe "Deleting groups" do
  let(:user) { create(:user) }
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }

  before do
    sign_in user, password: "treehouse1"
  end

  it "is successful when clicking the destroy link" do
    visit "/groups"

    within "#group_#{group.id}" do
      click_link "Destroy"
    end

    expect(page).to_not have_content(group.name)
    expect(Group.count).to eq(0)
  end
end
