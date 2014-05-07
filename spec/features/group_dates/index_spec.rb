require 'spec_helper'

describe "Viewing group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creationDate: "2012-02-01") }

  def visit_group(group)
    visit "/groups"
    within "#group_#{group.id}" do
      click_link "List Dates"
    end
  end

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
    group.group_dates.create(name: "First of may", from_date: "2014-05-01", to_date: "2014-05-02", description: "A nice sample text.")
    group.group_dates.create(name: "Last of day", from_date: "2014-12-31", to_date: "2015-01-01", description: "A new sample text.")

    visit_group(group)

    expect(page.all("ul.group_dates li").size).to eq(2)

    within "ul.group_dates" do
      expect(page).to have_content("First of may")
      expect(page).to have_content("Last of day")
    end
  end
end
