require 'spec_helper'

describe "Viewing group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }
  
  it "displays the name of the group" do
    visit_group(group)
    within("h1") do
      expect(page).to have_content(group.name)
    end
  end

  it "displays no items when a group date list is empty" do
    visit_group(group)
    expect(page.all("ul.group_dates li").size).to eq(0)
  end

  it "displays date content when a group has dates" do
    group.group_dates.create(name: "First of may", place: "This place", from_date: DateTime.now, to_date: DateTime.now, description: "A nice sample text.")
    group.group_dates.create(name: "Last of day", place: "This place", from_date: DateTime.now, to_date: DateTime.now, description: "A new sample text.")

    visit_group(group)

    expect(page.all("ul.group_dates li").size).to eq(2)

    within "ul.group_dates" do
      expect(page).to have_content("First of may")
      expect(page).to have_content("Last of day")
    end
  end
end
