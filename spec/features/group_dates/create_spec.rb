require 'spec_helper'

describe "Adding group dates" do
  let!(:group) { group = Group.create(name: "Testgroup", creation_date: "2012-02-01") }
  let(:user) { create(:user) }

  before do
    sign_in user, password: "treehouse1"
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
