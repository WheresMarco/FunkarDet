require 'spec_helper'

describe "Adding group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }

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

  def create_group_date(options={})
    options[:name] ||= "Testdate"
    options[:place] ||= "Placetest"
    options[:from_date] ||= DateTime.now
    options[:to_date] ||= DateTime.now
    options[:description] ||= "A sample text"

    click_link "New Group Date"

    fill_in "Name", with: options[:name]
    fill_in "Place", with: options[:place]

    select_date_and_time(options[:from_date], prefix: "group_date", from: :from_date)
    select_date_and_time(options[:to_date], prefix: "group_date", from: :to_date)

    fill_in "Description", with: options[:description]

    click_button "Save"
  end

  it "is successful with valid name" do
    visit_group(group)
    create_group_date name: "Testdate"

    expect(page).to have_content("Added group date.")

    within("ul.group_dates") do
      expect(page).to have_content("Testdate")
    end
  end

  it "displays an error with no name" do
    visit_group(group)
    create_group_date name: ""

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that group date.")
    end

    expect(page).to have_content("Name can't be blank")
  end

  it "displays an error with a name less then 2 characters long" do
    visit_group(group)
    create_group_date name: "1"

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that group date.")
    end

    expect(page).to have_content("Name is too short")
  end

  it "displays an error with no place" do
    visit_group(group)
    create_group_date place: ""

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that group date.")
    end

    expect(page).to have_content("Place can't be blank")
  end

  it "displays an error with no place less then 2 characters long" do
    visit_group(group)
    create_group_date place: ""

    within("div.flash") do
      expect(page).to have_content("Threre was a problem adding that group date.")
    end

    expect(page).to have_content("Place can't be blank")
  end
end
