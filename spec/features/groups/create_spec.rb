require 'spec_helper'

describe "Creating groups" do
  def select_date(date, options = {})
    field = options[:prefix].to_s + "_".to_s + options[:from].to_s
    select date.strftime('%Y'), :from => "#{field}_1i" #year
    select date.strftime('%B'), :from => "#{field}_2i" #month
    select date.strftime('%-e'), :from => "#{field}_3i" #day
  end

  def create_group(options={})
    options[:name] ||= "Testgroup"
    options[:creation_date] ||= Date.today

    visit "/groups"
    click_link "New Group"
    expect(page).to have_content("New group")

    fill_in "Name", with: options[:name]

    select_date(options[:creation_date], prefix: "group", from: :creation_date)

    click_button "Create Group"
  end

  it "redirects to the group list index page on success" do
    create_group
    expect(page).to have_content("Testgroup")
  end

  it "displays an error when the group has no name" do
    expect(Group.count).to eq(0)

    create_group name: ""

    expect(page).to have_content("error")
    expect(Group.count).to eq(0)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end

  it "displays an error when the group has a name less then 3 characters" do
    expect(Group.count).to eq(0)

    create_group name: "Hi"

    expect(page).to have_content("error")
    expect(Group.count).to eq(0)

    visit "/groups"
    expect(page).to_not have_content("Testgroup")
  end
end
