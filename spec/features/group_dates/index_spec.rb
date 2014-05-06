require 'spec_helper'

describe "Viewing group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creationDate: "2012-02-01") }

  it "displays no items when a group date list is empty" do
    visit "/groups"

    within "#group_#{group.id}" do
      click_link "List Dates"
    end
    
    expect(page).to have_content("GroupDates#index")
  end
end
