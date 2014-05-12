require 'spec_helper'

describe "Deleting group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }
  let!(:group_date) { group.group_dates.create(name: "Last of day", place: "This place", from_date: DateTime.now, to_date: DateTime.now, description: "A new sample text.") }

  it "is successful" do
    visit_group(group)

    within "#group_date_#{group_date.id}" do
      click_link "Delete"
    end

    expect(page).to have_content("Group date was deleted.")
    #expect(GroupDate.count).to eq(0)
  end
end
