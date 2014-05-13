require 'spec_helper'

describe "Deleting group dates" do
  let!(:group_date) { group.group_dates.create(name: "Last of day", place: "This place", from_date: DateTime.now, to_date: DateTime.now, description: "A new sample text.") }
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "is successful" do
    visit_group_dates(group)

    within "#group_date_#{group_date.id}" do
      click_link "Delete"
    end

    expect(page).to have_content("Group date was deleted.")
    #expect(GroupDate.count).to eq(0)
  end
end
