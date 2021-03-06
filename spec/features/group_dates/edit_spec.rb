require 'spec_helper'

describe "Editing group dates" do
  let!(:group_date) { group.group_dates.create(name: "Last of day", place: "This place", from_date: DateTime.now, to_date: DateTime.now, description: "A new sample text.") }
  let!(:group) { create(:group) }

  before do
    sign_in group.user, password: "treehouse1"
  end

  it "is successful with valid name" do
    visit_group_dates(group)

    within "#group_date_#{group_date.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: "New Name"
    click_button "Save"

    expect(page).to have_content("Saved date.")
    group_date.reload

    expect(group_date.name).to eq("New Name")
  end

  it "is unsuccessful with no name" do
    visit_group_dates(group)

    within "#group_date_#{group_date.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: ""
    click_button "Save"

    expect(page).to_not have_content("Saved group date.")
    expect(page).to have_content("can't be blank")
    group_date.reload

    expect(group_date.name).to eq("Last of day")
  end

  it "is unsuccessful with not enough name" do
    visit_group_dates(group)

    within "#group_date_#{group_date.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: "1"
    click_button "Save"

    expect(page).to_not have_content("Saved group date.")
    expect(page).to have_content("is too short")
    group_date.reload

    expect(group_date.name).to eq("Last of day")
  end

end
