require 'spec_helper'

describe "Editing group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }
  let!(:group_date) { group.group_dates.create(name: "Last of day", place: "This place", from_date: DateTime.now, to_date: DateTime.now, description: "A new sample text.") }

  def select_date_and_time(date, options = {})
    field = options[:prefix].to_s + "_".to_s + options[:from].to_s
    select date.strftime('%Y'), :from => "#{field}_1i" #year
    select date.strftime('%B'), :from => "#{field}_2i" #month
    select date.strftime('%-e'), :from => "#{field}_3i" #day
    select date.strftime('%H'), :from => "#{field}_4i" #hour
    select date.strftime('%M'), :from => "#{field}_5i" #minute
  end

  def visit_group(group)
    visit "/groups"
    within "#group_#{group.id}" do
      click_link "List Dates"
    end
  end

  it "is successful with valid name" do
    visit_group(group)

    within "#group_date_#{group_date.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: "New Name"
    click_button "Save"

    expect(page).to have_content("Saved group date.")
    group_date.reload

    expect(group_date.name).to eq("New Name")
  end

  it "is unsuccessful with no name" do
    visit_group(group)

    within "#group_date_#{group_date.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: ""
    click_button "Save"

    expect(page).to_not have_content("Saved group date.")
    expect(page).to have_content("Name can't be blank")
    group_date.reload

    expect(group_date.name).to eq("Last of day")
  end

  it "is unsuccessful with not enough name" do
    visit_group(group)

    within "#group_date_#{group_date.id}" do
      click_link "Edit"
    end

    fill_in "Name", with: "1"
    click_button "Save"

    expect(page).to_not have_content("Saved group date.")
    expect(page).to have_content("Name is too short")
    group_date.reload

    expect(group_date.name).to eq("Last of day")
  end

end
